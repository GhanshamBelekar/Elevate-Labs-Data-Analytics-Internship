Task 1: Data Cleaning and Preprocessing — Sales Data

Objective:
Clean and prepare the raw `Sales_data.csv` (1,000 rows, 10 columns) for analysis, following the hints in the internship task brief.

Dataset:
Source: Kaggle "Sales Data" — sales transactions across European countries (country, order value, cost, date, category, customer, sales team, device type, order ID).

1.Steps Performed:

Missing values :
     Checked with    `.isnull().sum()`.  
      Result: 0 missing values found in the raw data.

Duplicates:
      Checked with  `.duplicated().sum()`  .
       Result: 0 duplicate rows found.


Column headers 
        Stripped stray whitespace (e.g. `" order_value_EUR "` → `order_value_eur`) and standardized all                             headers to lowercase.

Numeric formatting:
        `order_value_eur` was stored as text with thousands-separator commas (e.g. `"17,524.02"`). Converted to a proper float column.

Data types:
         Verified `cost` and `order_value_eur` as `float64`; `order_id` kept as string (it contains a leading-zero prefix, e.g. `02-3972649`, which would be lost as an integer).

Text standardization:
          Trimmed leading/trailing whitespace on all text columns (country, category, customer_name, sales_manager, sales_rep, device_type). Country and category values were already consistently spelled (no "UK" vs "United Kingdom" style mismatches).

Date format:
          Converted `date` from inconsistent `M/D/YYYY` text to proper `datetime`, then standardized output to `dd-mm-yyyy` as specified in the task hints.

Column order:
 Reordered columns for readability: `order_id, date, country, category, device_type, customer_name, sales_manager, sales_rep, order_value_eur, cost`.





Result:

| Metric | Value |
|---|---|
| Rows (raw) | 1000 |
| Rows (cleaned) | 1000 |
| Missing values found | 0 |
| Duplicate rows removed | 0 |
| Columns renamed | 10/10 (whitespace/casing) |
| Numeric conversions | order_value_eur (text → float) |
| Date format fixed | 1000 rows standardized to dd-mm-yyyy |



- `Cleaned Data.csv` — the cleaned dataset
- `Data Cleaning,ipynb` — the Python/Pandas script used to produce it

 Tools Used:
-Python (Pandas)

