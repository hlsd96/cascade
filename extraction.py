#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Feb 15 01:39:34 2023

@author: hectorsanchez
"""

import pandas as pd
import os as os


#os.getcwd() 
os.chdir('/Users/hectorsanchez/Documents/DEVELOPMENT/DBT/cascade') #Change current directory



#Read each sheet
europe = pd.read_excel('carmen_sightings_20220629061307.xlsx','EUROPE')
asia = pd.read_excel('carmen_sightings_20220629061307.xlsx','ASIA')
africa = pd.read_excel('carmen_sightings_20220629061307.xlsx','AFRICA')
america = pd.read_excel('carmen_sightings_20220629061307.xlsx','AMERICA')
australia = pd.read_excel('carmen_sightings_20220629061307.xlsx','AUSTRALIA')
atlantic = pd.read_excel('carmen_sightings_20220629061307.xlsx','ATLANTIC')
indian = pd.read_excel('carmen_sightings_20220629061307.xlsx','INDIAN')
pacific = pd.read_excel('carmen_sightings_20220629061307.xlsx','PACIFIC')



#Column replacement:
#DBT will not be able to seed the CSV files if they contain column names in mandarin or question marks in the column names.
asia.rename(columns={'报道': 'date_agent', '纬度':'latitude','经度':'longitude'}, inplace=True)
europe.rename(columns={'armed?': 'armed', 'chapeau?':'chapeau','coat?':'coat'}, inplace=True)

#Export data to CSV files in seeds

os.chdir('/Users/hectorsanchez/Documents/DEVELOPMENT/DBT/cascade/cascade_proj/seeds') #Go to the seeds folder

europe.to_csv('seed_europe.csv')
asia.to_csv('seed_asia.csv')
africa.to_csv('seed_africa.csv')
america.to_csv('seed_america.csv')
australia.to_csv('seed_australia.csv')
atlantic.to_csv('seed_atlantic.csv')
indian.to_csv('seed_indian.csv')
pacific.to_csv('seed_pacific.csv')

