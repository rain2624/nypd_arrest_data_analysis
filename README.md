# Analyzing Arrest Data Of NewYork City (Data Engineering Zoomcamp Project) 

This repo contains the project submission for [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main) Course.


## Dataset
For this project I have used [NYPD Arrests Data (Historic)](https://data.cityofnewyork.us/Public-Safety/NYPD-Arrests-Data-Historic-/8h9b-rp9u/about_data) From [NYC Open Data](https://opendata.cityofnewyork.us/). 
This dataset is a breakdown of every arrest effected in NYC by the NYPD going back to 2006 through the end of the previous calendar year. This data is manually extracted every quarter and reviewed by the Office of Management Analysis and Planning before being posted on the NYPD website. 
Each record represents an arrest effected in NYC by the NYPD and includes information about the type of crime, the location and time of enforcement.

## Problem Statement:
Analyze the NYPD arrest data from 2008-2023 (15 years) to uncover long-term trends and patterns in crime across New York City. The objective is to understand how arrest counts have evolved over time across boroughs, crime categories (felonies, misdemeanors, violations), and demographic groups (age, race, sex).

## Technologies used:
- This project is typically a **batch project**. It involvles the following technologies:
1. Data Ingestion - [Socrata Open Data API(SODA)](https://dev.socrata.com/foundry/data.cityofnewyork.us/8h9b-rp9u)
2. Containerization - Docker (For running Airflow)
3. Orchestration - Airflow
4. IAAC - Terraform
5. Environment to run project - Google Cloud Virtual Machine (VM)
6. Data Warehouse - Google Big Query 
7. Data Transformation - DBT
8. Data Visualization - Power-bi

## Architecture

![alt text](architecture_diagram.png)

## Steps to follow:

### General Instruction: 
1. Need to create a Google Cloud Account (free account for first time user with 300$ credits for more info visit this [link](https://cloud.google.com/free/docs/free-cloud-features)). To create one visit this [link](https://k21academy.com/google-cloud/create-google-cloud-free-tier-account/)

2. Before starting with the project we need to set up a Service Account in Google Cloud Platform which would give our applications (like terraform, airflow etc) access to Bigquery, Google Cloud Storage, etc.
To set up service account you follow this [link](https://cloud.google.com/iam/docs/service-accounts-create) for reference.
- Go to GCP.
- Go to IAM Admin (on the right side you can see option for Navigator Bar). 
- Again on Right Side option to create Service Account.
- You also need to create keys, go to Service Accounts --> you will see list of your Service accounts --> look for your account and when you click Actions --> manage keys --> Add key --> Json Key would be downloaded --> store it in proper place and not to show it (we will need this key later). 
![alt text](service_account.png)
- Give access to:
    - Compute Engine Admin
    - BigQuery Admin
    - Storage Admin

3. For this project I also have generate App token on NYC open data portal.
- Go to the dataset with [link](https://data.cityofnewyork.us/Public-Safety/NYPD-Arrests-Data-Historic-/8h9b-rp9u) and then go to Actions --> API --> API documentation --> Under App Token Sign up for an app token --> Under App Token --> Create new App Token (Do not share this and save it in some file).

4. For this project create a new git repository in both local and githhub. 

### 1. Virtual Machine 
- I advice you to do this section later first create terraform code folder and your airflow + docker code folder and then test small part of both the things whether running on local or not and if it works then push the code in your new github repo to run via VM all together.
- ##### Instructions to follow:


### 2. Airflow and Docker

### 3. Datawarehouse (Big Query)

### 4. DBT

### 5. Power-bi




