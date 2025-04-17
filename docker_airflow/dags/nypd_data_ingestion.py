# loading libraries
import os
from airflow import DAG
from datetime import datetime
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from google.cloud import storage
from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateExternalTableOperator
import pyarrow.parquet as pq
from read_data import loading_data
from dateutil.relativedelta import relativedelta


# calling variables from .env
PROJECT_ID= os.environ.get("GCP_PROJECT_ID")
BUCKET=os.environ.get("GCP_GCS_BUCKET")
api_token = os.getenv('api_token')


AIRFLOW_HOME= os.environ.get("AIRFLOW_HOME","/opt/airflow")

# defining default args
default_args= {
    "owner": "airflow",
    "start_date": datetime(2012,12,30),
    "end_date": datetime(2024,1,1),
    # "end_date": datetime(2024,1,1),
    "depends_on_past": False,
    "retries": 1,
}

# Defining Dag
nypd_arrest_workflow = DAG(
    dag_id="data_ingestion_gcs_dag",
    schedule_interval="0 18 2 * *",
    default_args=default_args,
    catchup=True,
    max_active_runs=3, # Only one active run of the DAG is allowed at a time
    tags=['nypd-arrest'],
    params={
        "relativedelta": relativedelta
    }
) 

# defining input and output file path
domain = "data.cityofnewyork.us"
dataset_id = "8h9b-rp9u"
output_file = 'nypd_arrest_{{ execution_date. strftime(\'%Y_%m\') }}.parquet'
year = '{{ execution_date .strftime("%Y") }}'


# function to add data in gcs
def upload_to_gcs(bucket, year, local_path):
    local_file = os.path.basename(local_path)
    """
    Ref: https://cloud.google.com/storage/docs/uploading-objects#storage-upload-object-python
    :param bucket: GCS bucket name
    :param object_name: target path & file-name
    :param local_file: source path & file-name
    :return:
    """
    object_name=f"nypd_arrest_data/{year}/{local_file}"
    storage.blob._MAX_MULTIPART_SIZE= 5 * 1024 * 1024 #5MB
    storage.blob._DEFAULT_MAX_SIZE=5 * 1024 * 1024 #5MB

    client= storage.Client()
    bucket= client.bucket(bucket)

    blob=bucket.blob(object_name)
    blob.upload_from_filename(local_path)


with nypd_arrest_workflow:
    # task 1- to access api (read data --> parquet file)
    read_data_api = PythonOperator(
        task_id='read_data_api',
        python_callable=loading_data,
        op_kwargs=dict(
            api_data=api_token,
            domain=domain,
            start_date='{{ execution_date .strftime("%Y-%m-01T00:00:00.000") }}',
            end_date='{{ (execution_date + params.relativedelta(months=1)).strftime("%Y-%m-01T00:00:00.000") }}',
            parquet_file=output_file,
            dataset_id=dataset_id,
        )
    )

    
    # task2- adding data in GCS year-wise in a folder.
    local_to_gcs = PythonOperator(
        task_id='local_to_gcs',
        python_callable=upload_to_gcs,
        op_kwargs={
            "bucket": BUCKET,
            "year": '{{ execution_date .strftime("%Y") }}',
            "local_path": f"{AIRFLOW_HOME}/{output_file}"
        }
    )

    # task3 - clean-up loaded parquet file from local.
    cleanup_task = BashOperator(
    task_id='cleanup_task',
    bash_command=f'rm {AIRFLOW_HOME}/{output_file}')
    
    read_data_api >> local_to_gcs >> cleanup_task