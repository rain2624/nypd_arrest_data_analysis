## DBT - NYPD Data Modelling
- To set-up dbt you need create account and then you need to go to Settings on left side top.
- Add big- query info below like service-account credential (.josn file you downloaded).
- Once done connect to git repo which have project folder.
- For more detail you can visit this [link](https://docs.getdbt.com/guides/bigquery?step=1)

- Here, the aim is to perform data modelling for our nypd_arrest_2008_2023 dataset to dimension and fact tables.
- First visit dbt_project.yml file to edit prject name as per the name you want to see in bigquery. For me it is nypd_data_modelling. There are more changes which can be seen from my file.
- Inside model folder there are two sub-folders:
    - staging
        - In this folder we have schema.yml and stg_nypd_arrest_2008_2023.sql.
        - The schema.yml defines the source table and columns used.
        - the stg_nypd_arrest_2008_2023.sql helps to redefine the data-types of column in the source table.
    - core
        - In this folder we do the main task of converting table in to following dim and fact table with it's respective changes that can be seen in code file.
- After creating each file. I was running dbt build in it dbt command prompt and also selecting code and running preview selection to see the results are same as ecpected.
- I have also write test in scehma.yml file for each folder. At the end I have ran the below code one by one and also viewed docs at top left.
 ```dbt
dbt build
dbt run
dbt docs generate
dbt docs serve
```
![alt text](dbt_docs.png)

- Once all is done, you can see in bigquery studio schema nypd_data-modelling and see dataset/tables.
- Now, you need **Deploy In Prod**. For that visit Deploy --> Environments --> Create environment --> Production (in my case).
- Fill Job settings, Execution settings (check all except the resource freshness) and no need to fill rest.
- Click on Run now and you could see the Run job, click on the job to see the results manually.
- Once completed you can again see the schema (Prod) in big query with final tables. 



