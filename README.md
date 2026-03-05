## Execution Order

To reproduce the full analysis, the files should be executed in the following order.

### 1. Data Extraction (SQL)

**File:** `Data_Extract.sql`

This script extracts the relevant user and booking data from the database.  
It prepares the raw dataset that will be used for the subsequent Python analysis.

---

### 2. Data Preprocessing

**Notebook:** `preprocessing.ipynb`

Main tasks:
- loading the extracted dataset
- cleaning the data
- handling missing values
- preparing variables for further analysis

Output: a cleaned dataset ready for exploration.

---

### 3. Exploratory Data Analysis (EDA)

**Notebook:** `data_exploration.ipynb`

Main tasks:
- exploring travel behavior patterns
- analyzing booking activity
- identifying initial patterns and relationships in the data
- visualizing key variables

---

### 4. Detecting Canceled Trips

**Notebook:** `detecting_canceled_trips.ipynb`

Main tasks:
- identifying canceled trips in the dataset
- analyzing cancellation behavior
- preparing cancellation-related variables for later analysis

---

### 5. Feature Engineering

**Notebook:** `feature_engineering.ipynb`

Main tasks:
- creating behavioral features
- aggregating user booking statistics
- transforming variables for machine learning models

Output: a feature-rich dataset prepared for dimensionality reduction.

---

### 6. Dimensionality Reduction (PCA)

**Notebook:** `pca.ipynb`

Main tasks:
- scaling the dataset
- applying Principal Component Analysis (PCA)
- reducing dimensionality
- identifying the most important behavioral components

---

### 7. Customer Segmentation

**Notebook:** `kmeans.ipynb`

Main tasks:
- applying KMeans clustering
- identifying the optimal number of clusters
- assigning users to traveler segments

---

### 8. Cluster Analysis and Interpretation

**Notebook:** `clusteranalysis.ipynb`

Main tasks:
- interpreting the resulting clusters
- identifying behavioral traveler profiles
- linking clusters to targeted perk recommendations

Output: six traveler segments with personalized perk strategies.
