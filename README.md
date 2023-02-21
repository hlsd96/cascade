### 1. DATA EXTRACTION

The first step of this asessment is to extract data from `carmen_sightings_20220629061307.xlsx` in order to achieve this, I created extraction.py which basically reads the 8 sheets from the Excel files and generates 8 CSV files in the seeds folder: 
[![Python_extraction](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/python.png "Python_extraction")](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/python.png "Python_extraction")

####Snowflake setup
It is also important to set up an environment where all the objects and data are stored, for this I used Snowflake which offers a convenient integration with DBT. You have access to the setup logic in `Snowflake Environment Setup.sql`.
