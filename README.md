# EMS Registry Anomaly Detection
A Julia-based framework for data quality surveillance in statewide EMS registry reporting.

## Overview

This project implements a reproducible analytic workflow for detecting anomalous reporting patterns in agency‑level submissions to the Iowa EMS Registry (2020–present).

The objective is to identify irregular year‑over‑year fluctuations that may indicate data quality issues, reporting gaps, record processing problems, or operational changes requiring follow‑up with EMS agencies.

The system is designed for epidemiologists, surveillance analysts, and data scientists who need transparent and statistically rigorous methods for longitudinal monitoring of EMS registry data.
Key Features

- Full data union across reporting years (2020–present) with schema‑aligned field selection.
- Automated reshaping to produce wide‑format agency‑year reporting matrices.
- Derivation of absolute and percent year‑over‑year differences in record counts or key reporting metrics.
- Agency‑level summary statistics including mean, variance, and standard deviation of counts and differences.
- Z‑score‑based anomaly detection to identify agencies with $SD >=1.5$ deviations from their historical reporting pattern.
- Percent‑change detection to flag extreme shifts $(|percent\_change| >=0.50)$.
- High‑level anomaly indicators that summarize whether each agency exhibits any unexpected patterns across years.

## Visualization suite includes:

- Statewide density plots of year‑to‑year differences
- Agency‑specific raincloud distribution profiles
- Agency‑specific column/bar plots showing direction and magnitude of changes
- Combined statewide distributional overview across all reporting agencies

## Analytic Approach

Reporting differences are computed for each transition (2020 -> 2021 through 2024 -> 2025).

### For each EMS agency:

#### Absolute difference:

$diff_{year} = records_{year} - records_{previous\_year}$

#### Percent difference:
pctyear=diffyearrecordsprevious_year

$pct_{year} = \frac{diff_{year}}{records_{previous\_year}}$

#### Statistical standardization:

$z = \frac{(diff_{year} - mean_{diff})}{sd_{diff}}$

#### Binary anomaly thresholds:

$abs(z) >= 1.5$

$abs(percent\_diff) >= 0.5$

### Summary anomaly indicators across all reporting years

These outputs support structured data quality review, targeted follow‑up, and operational interpretation.

## Visual Analytics
The analysis produces statewide and agency‑level visualizations:

- Density estimation of absolute and percent differences
- Raincloud plots capturing within‑agency variability
- Column plots illustrating magnitude and direction of reporting shifts
- Aggregated statewide raincloud visualization

### Technologies and Dependencies

This project uses a modern Julia workflow for data ingestion, transformation, statistical analysis, and reproducible reporting.

#### Core Data Manipulation

- Tidier.jl – Tidy‑syntax transformation pipelines
- TidierDates.jl – Date parsing and manipulation
- DataFrames.jl – Tabular structures and joins
- XLSX.jl - High-performance Excel file I/0
- CSV.jl – High‑performance delimited file I/O

### Visualization

- TidierPlots.jl – Grammar‑of‑graphics plotting in a tidy interface

### Statistical Computation

- Dates.jl – Handling of date and time fields
- Statistics – Core measures including mean, variance, and standard deviation

### Configuration and Environment Management

- DotEnv.jl – Secure handling of Iowa EMS registry filepaths through environment variables

### Reporting

- Quarto.jl – Fully reproducible reporting and documentation
- PrettyTables.jl – High‑quality summary tables

### Package Environment

- Pkg – Reproducible environment activation and dependency management

## Purpose and Intended Use
This workflow supports EMS system performance monitoring and routine data quality assurance. It is designed for:

- EMS registry program staff
- EMS epidemiologists
- Health services analysts
- Data scientists evaluating longitudinal EMS reporting quality