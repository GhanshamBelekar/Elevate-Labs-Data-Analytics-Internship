# Task 1: Data Cleaning and Preprocessing — Sales Data

## Objective
Clean and prepare the raw `Sales_data.csv` (1,000 rows, 10 columns) for analysis, following the hints in the internship task brief.

## Dataset
Source: Kaggle "Sales Data" — sales transactions across European countries (country, order value, cost, date, category, customer, sales team, device type, order ID).

## Steps Performed

1. **Missing values** — Checked with `.isnull().sum()`. Result: 0 missing values found in the raw data.
2. **Duplicates** — Checked with `.duplicated().sum()` and removed with `.drop_duplicates()`. Result: 0 duplicate rows found.
3. **Column headers** — Stripped stray whitespace (e.g. `" order_value_EUR "` → `order_value_eur`) and standardized all headers to lowercase snake_case.
4. **Numeric formatting** — `order_value_eur` was stored as text with thousands-separator commas (e.g. `"17,524.02"`). Converted to a proper float column.
5. **Data types** — Verified `cost` and `order_value_eur` as `float64`; `order_id` kept as string (it contains a leading-zero prefix, e.g. `02-3972649`, which would be lost as an integer).
6. **Text standardization** — Trimmed leading/trailing whitespace on all text columns (country, category, customer_name, sales_manager, sales_rep, device_type). Country and category values were already consistently spelled (no "UK" vs "United Kingdom" style mismatches).
7. **Date format** — Converted `date` from inconsistent `M/D/YYYY` text to proper `datetime`, then standardized output to `dd-mm-yyyy` as specified in the task hints.
8. **Column order** — Reordered columns for readability: `order_id, date, country, category, device_type, customer_name, sales_manager, sales_rep, order_value_eur, cost`.

## Result

| Metric | Value |
|---|---|
| Rows (raw) | 1000 |
| Rows (cleaned) | 1000 |
| Missing values found | 0 |
| Duplicate rows removed | 0 |
| Columns renamed | 10/10 (whitespace/casing) |
| Numeric conversions | order_value_eur (text → float) |
| Date format fixed | 1000 rows standardized to dd-mm-yyyy |

**Note:** this dataset didn't actually contain missing values or duplicate rows — it was checked and confirmed clean on those fronts. The real issues were the currency-formatted number column, messy column headers, and inconsistent date formatting, all of which are now fixed.

## Files
- `Sales_data_cleaned.csv` — the cleaned dataset
- `clean_sales_data.py` — the Python/Pandas script used to produce it
- `README.md` — this summary

## Tools Used
Python (Pandas)
