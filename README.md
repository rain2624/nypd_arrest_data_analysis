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

## 


