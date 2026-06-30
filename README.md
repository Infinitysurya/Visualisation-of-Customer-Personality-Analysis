# Customer Personality Analysis & Interactive Dashboard

## Project Overview
Understanding customer behavior is the cornerstone of any successful marketing strategy. This project performs a comprehensive Customer Personality Analysis to help a hypothetical company segment its customer base, understand purchasing habits, and optimize marketing campaigns. 

Instead of spending money marketing a new product to every customer in the database, this analysis identifies which customer segments are most likely to buy specific products (like wine, meat, or gold) and pinpoints the most profitable demographic groups.

The project consists of two main components:
1. **Exploratory Data Analysis (EDA):** A detailed R Markdown report that cleans the data and visualizes purchasing distributions.
2. **Interactive R Shiny Dashboard:** A dynamic web application allowing users to explore customer insights, heatmaps, and K-means clustering interactively.

---

## Dataset Information
* **Source:** [Customer Personality Analysis on Kaggle](https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis)
* **Original Author:** Dr. Omar Romero-Hernandez

### Key Features Used:
* `Year_Birth` & `Income`: Demographic markers used to calculate Age and spending power.
* `Education` & `Marital_Status`: Categorical features defining the customer's background.
* `MntWines`, `MntMeatProducts`, `MntGoldProds`, `MntFishProducts`, `MntSweetProducts`, `MntFruits`: Amount spent on various commodities over the last 2 years.

---

## Repository Contents
* **`customer_analysis.Rmd`**: The R Markdown document containing the static Exploratory Data Analysis. It includes data cleaning (handling NAs, outlier removal, age calculation) and statistical visualizations.
* **`app.R`**: The R Shiny application (`shinydashboard`) script. It generates an interactive UI with four main tabs: Introduction, Customer Insights, Conclusion, and About Me.

---

## Prerequisites & Setup

To run this project locally, you will need **R** and **RStudio** installed on your machine.

### Required R Packages
Open your RStudio console and run the following command to install all necessary dependencies:

```R
install.packages(c("shiny", "shinydashboard", "dplyr", "ggplot2", "plotly", "cluster", "factoextra", "corrplot", "tidyr", "lubridate", "GGally", "RColorBrewer", "gridExtra"))
