### PROJECT STRUCTURE:
The solution to this assessment is based on the following structure: 

[![](https://github.com/hlsd96/cascade/blob/c83b1af0eb5043b864be9515db88ef3351ba409e/graphic_resources/github.png)](https://github.com/hlsd96/cascade/blob/c83b1af0eb5043b864be9515db88ef3351ba409e/graphic_resources/github.png)

- The DBT project is contained in the cascade_proj folder
- Scripts outside the scope of DBT are stored in the root directory
- Screenshots, diagrams, query results and other graphics are stored in the graphic_resources folder.

### 1. DATA EXTRACTION
---

The first step of this asessment is to extract data from `carmen_sightings_20220629061307.xlsx` in order to achieve this, I created `extraction.py` which basically reads the 8 sheets from the Excel files and generates 8 CSV files in the seeds folder: 

[![Python_extraction](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/python.png "Python_extraction")](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/python.png "Python_extraction")

Please note that only a small alteration is made to a few columns as they have special characters and some of them are written in mandarin; for this reason `carmen_sightings_20220629061307.xlsx` also modifies such column names so that DBT does not encounter any issue trying to process those datasets. 

####Snowflake setup
It is also important to set up an environment where all the objects and data are stored, for this I used Snowflake which offers a convenient integration with DBT. You have access to the setup logic in `Snowflake Environment Setup.sql`.
[![](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/setup.png)](https://github.com/hlsd96/cascade/blob/2e7b1c155d7286dcbe7c3928394907f89d6ac9d9/graphic_resources/setup.png)

### 2. COLUMN MAPPING
---
Now that the corresponding CSV files are stored in the seeds folder, it is possible to develop initial models to map and standardize column names that are received from the source. 
Please note that the seed sources are referenced as **sources** and a `sources.yml `file was created for that purpose:

[![sources.yml](https://github.com/hlsd96/cascade/blob/50b89cb6c3d456783ca3964fa11ea05688babfb4/graphic_resources/sources.png)](https://github.com/hlsd96/cascade/blob/50b89cb6c3d456783ca3964fa11ea05688babfb4/graphic_resources/sources.png)

One model was created for each reagion and these modeles can be found in `cascade/cascade_proj/models/src/`
Since no configuration was given to these models, they are created as views by default with the use of CTEs. 


### 3. CREATION OF DATA MODEL
---
The process that was followed to create a model for this scenario is based on the identification of individual entities that represent concepts in the game. The fact that this model needs to be > 1NF is also taken into account.

The following is the data model that was designed for this scenario:

[![data_model](https://github.com/hlsd96/cascade/blob/31de8ff819fd88940c9aa5dd573050a81c107ad1/graphic_resources/ERD.png)](https://github.com/hlsd96/cascade/blob/31de8ff819fd88940c9aa5dd573050a81c107ad1/graphic_resources/ERD.png)

The models that were created to populate the above entities can be found in `cascade/cascade_proj/models/prod/` 

Main considerations: 

- The source does not have unique identifiers for reports or sightings and for this reason IDs were fabricated with the help of `dbt-labs/dbt_utils` (this package is invoked in `packages.yml`)
- The materialization of these models is defined as "Incremental" based on the assumption that the models are periodically executed and the tables are populated in an incremental manner however, develempment works oriented to prevent duplicates are outside the scope of this implementation. 

The following lineage graph represents the materalization of the data model that was created and how it is used to generate views that answer question 4: 

[![lineage_graph](https://github.com/hlsd96/cascade/blob/02c6b7afd5a5e422de57b8c8bece801fc535a0ba/graphic_resources/lineage_graph.png "lineage_graph")](https://github.com/hlsd96/cascade/blob/02c6b7afd5a5e422de57b8c8bece801fc535a0ba/graphic_resources/lineage_graph.png "lineage_graph")


### 4. Analytics
---
##### Assumptions
1. The characteristics that describe Carmen Sandiego are not explicitly specified so it is assumed that this character wears jacket AND hat but does noe necessarily carry a weapon. This assumption influences the way I have created the views to answer questions.
2. The calculation of probabilities are based on the following definition: 
[![probability_def](https://github.com/hlsd96/cascade/blob/02c6b7afd5a5e422de57b8c8bece801fc535a0ba/graphic_resources/probability_def.png "probability_def")](https://github.com/hlsd96/cascade/blob/02c6b7afd5a5e422de57b8c8bece801fc535a0ba/graphic_resources/probability_def.png "probability_def")


##### Solutions
For the 4th step of this assessment, I created 4 separate views in a different schema (`dev_mart`) and the corresponding models can be found in `cascade/cascade_proj/models/mart/`.
All my solutions contain some sort of aggregations as required by the nature of the four questions, the also involve case statements to address multiple scenarios (which could probably be implemented by pivoting tables as an alternative). 

As it is shown in the dbt models, all four views reference the sighting or the report models because of the way the data model was designed, this model facilitates the join of both tables and provides a convenient way to ingest data.

a. For each month, which agency region is Carmen Sandiego most likely to be found?

[![results_q1](https://github.com/hlsd96/cascade/blob/cbd70acdb159f2a60fb047d860cca8234636ef9d/graphic_resources/q1_table.png "results_q1")](https://github.com/hlsd96/cascade/blob/cbd70acdb159f2a60fb047d860cca8234636ef9d/graphic_resources/q1_table.png "results_q1")

Based on the results provided by this view it is possible to compare the probabilities fore each moth and each region as shown below: 

[![results_q1b](https://github.com/hlsd96/cascade/blob/cbd70acdb159f2a60fb047d860cca8234636ef9d/graphic_resources/q1_result.png "results_q1b")](https://github.com/hlsd96/cascade/blob/cbd70acdb159f2a60fb047d860cca8234636ef9d/graphic_resources/q1_result.png "results_q1b")

b. Also for each month, what is the probability that Ms. Sandiego is armed AND wearing a jacket, but NOT a hat? What general observations about Ms. Sandiego can you make from this?

[![results_q2](https://github.com/hlsd96/cascade/blob/17b78d39d5d2a03b2645e16f9021d8c9c3c75920/graphic_resources/answer_q2.png "results_q2")](https://github.com/hlsd96/cascade/blob/17b78d39d5d2a03b2645e16f9021d8c9c3c75920/graphic_resources/answer_q2.png "results_q2")

c. What are the three most occuring behaviors of Ms. Sandiego?

[![answer_q3](https://github.com/hlsd96/cascade/blob/17b78d39d5d2a03b2645e16f9021d8c9c3c75920/graphic_resources/answer_question_three.png "answer_q3")](https://github.com/hlsd96/cascade/blob/17b78d39d5d2a03b2645e16f9021d8c9c3c75920/graphic_resources/answer_question_three.png "answer_q3")


d. For each month, what is the probability Ms. Sandiego exhibits one of her three most occurring behaviors?

[![answer_q4](https://github.com/hlsd96/cascade/blob/17b78d39d5d2a03b2645e16f9021d8c9c3c75920/graphic_resources/answer_question_four.png)](https://github.com/hlsd96/cascade/blob/17b78d39d5d2a03b2645e16f9021d8c9c3c75920/graphic_resources/answer_question_four.png)

###End