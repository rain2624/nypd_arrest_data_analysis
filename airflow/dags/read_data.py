import pandas as pd
import os
from dateutil.relativedelta import relativedelta
from sodapy import Socrata
import datetime as datetime



def loading_data(api_data, domain, start_date, end_date, parquet_file,dataset_id):
    print(f"We will be reading data from {start_date} to {end_date}")

    api_key = api_data
    #doing for a month 
    query= f"arrest_date >='{start_date}'  AND arrest_date < '{end_date}'"

    client = Socrata(domain, api_key)

    results = client.get(dataset_id, where=query)

    # Convert to pandas DataFrame
    results_df = pd.DataFrame.from_records(results)
    print("Completed with reading df")
    
    # Convert to numeric (integer or float as appropriate) where necessary
    results_df['arrest_precinct'] = pd.to_numeric(results_df['arrest_precinct'], errors='coerce')  
    results_df['jurisdiction_code'] = pd.to_numeric(results_df['jurisdiction_code'], errors='coerce')
    results_df['x_coord_cd'] = pd.to_numeric(results_df['x_coord_cd'], errors='coerce')
    results_df['y_coord_cd'] = pd.to_numeric(results_df['y_coord_cd'], errors='coerce')
    results_df['latitude'] = pd.to_numeric(results_df['latitude'], errors='coerce')
    results_df['longitude'] = pd.to_numeric(results_df['longitude'], errors='coerce')
    results_df['pd_cd'] = pd.to_numeric(results_df['pd_cd'], errors='coerce')
    results_df['ky_cd'] = pd.to_numeric(results_df['ky_cd'], errors='coerce')

    # Convert to datetime (timestamp)
    results_df['arrest_date'] = pd.to_datetime(results_df['arrest_date'], errors='coerce')
    results_df.drop(['lon_lat'], axis = 1, inplace=True)
    results_df['arrest_date'] = results_df['arrest_date'].dt.date
    results_df.to_parquet(parquet_file, engine='pyarrow')

    print("Testing df is loaded properly")
    check_df = pd.read_parquet(parquet_file, engine='pyarrow')
    print(check_df.head())
    print(check_df.info())

