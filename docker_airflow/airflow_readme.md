## Steps to follow:
1. Creating docker-compose.yaml
- open your gitbash and goto project folder, inside our project folder create dir 
```bash
mkdir docker_airflow

cd docker-airflow
```
- We will be running docker-compose.yaml code inside cmd prompt provided by official airflow docs
```bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.10.5/docker-compose.yaml'
```

- Initializing Environment
    - Before starting Airflow for the first time, you need to prepare your environment, i.e. create the necessary files, directories and initialize the database.

```bash
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env
```

- Open the airflow code file
```bash
code .
```

- On opening, go to docker-compose.yaml and in code section mark `False` for below section.
```bash
AIRFLOW__CORE__LOAD_EXAMPLES: 'false'
```

- Also there are changes in docker-compose.yaml part 
![alt text](dockercompose_yaml_changes.png)

2. Creating dockerfile
- Inside dockerfile for installing gcloud sdk I have used this [link](https://cloud.google.com/sdk/docs/install)
- Please refer my code file, here we just have install all ther required things like service account keys, gcloud sdk and requirements.txt file.

3. Creating entrypoint.sh and requirements.txt
- Please refer my code file.

4. Adding apptoken inside .env file
- You need to assign a token variable and add the token value here.

5. Creating dag and function to run 
- I have created a dag - nypd_data_ingestion.py, this download data from 2008 to 2023.
- Data is loaded monthly on 2nd day of each month @6:00pm.
- There are basically 3 task:
    1. read_data_api: Call another python function to get data in parquet form.
    2. local_to_gcs: Parquet data is loaded to GCS in format - year and it's respective parquet file from local
    3. clean_up_task: clean-up loaded parquet file from local.