# Microsoft Stock Price Forecasting

Time series analysis and forecasting of Microsoft (MSFT) stock prices using classical statistical models in R, comparing exponential smoothing methods against ARIMA to identify the best-performing forecasting approach. This project is part of the Time Series Analysis course - MSc Data Analytics at Rennes School of Business - France

## Project Overview

This project analyzes MSFT's monthly stock data (2019-2024) to understand its trend and seasonality, then builds and compares multiple **time series forecasting models** to predict future closing prices. The goal is not just to visualize stock behavior, but to rigorously evaluate which forecasting technique generalizes best on unseen (test) data using RMSE as the comparison metric.

## Objectives

- Retrieve and explore historical MSFT stock data (Open, High, Low, Close, Volume).
- Decompose the closing price series to identify trend and seasonal components.
- Build and compare four forecasting methods: **SES, Holt, Holt-Winters (additive & multiplicative)**.
- Fit an **ARIMA model** (auto-selected) as a benchmark against exponential smoothing methods.
- Evaluate all models with a train/test split and **RMSE**, and determine the best-performing model.

## Dataset

- **Source:** Yahoo Finance, retrieved via the `quantmod` package (`getSymbols`).
- **Ticker:** MSFT (Microsoft Corporation).
- **Period:** January 2019 - December 2024.
- **Frequency:** Monthly (72 observations).
- **Fields used:** Open, High, Low, Close, Volume.

## Analysis & Methodology

1. **Data Retrieval & Exploration**
   - Pulled MSFT historical prices directly from Yahoo Finance with `quantmod::getSymbols`.
   - Visualized Open, High, Low, Close, and Volume series with `autoplot`.

2. **Time Series Decomposition**
   - Converted each price series into a `ts` object (monthly frequency).
   - Applied `decompose()` on Open, High, Low, and Close to separate **trend, seasonal, and random** components.
   - Identified a slight upward trend with noticeable seasonality in the closing price.

3. **Train/Test Split**
   - Split the closing price series into training (~80%) and testing (remaining months) sets to validate model performance on unseen data.

4. **Forecasting Models**
   - **Simple Exponential Smoothing (SES)** — baseline for series without trend/seasonality.
   - **Holt's Linear Trend Method** — captures trend.
   - **Holt-Winters Additive** — captures trend + constant seasonal variation.
   - **Holt-Winters Multiplicative** — captures trend + seasonal variation proportional to the level.
   - **ARIMA (auto.arima)** — automatically selects the best-fitting ARIMA(p,d,q) model, fit both on the full series and on the training set for honest out-of-sample evaluation.

5. **Model Evaluation**
   - Calculated **RMSE** for SES, Holt, HW-Additive, HW-Multiplicative, and ARIMA on the test set.
   - Built a comparison table and automatically selected the method with the lowest RMSE as the best forecasting model.

## Tech Stack

- **Language:** R
- **Data source:** `quantmod` (Yahoo Finance API)
- **Time series & forecasting:** `forecast` (ses, holt, hw, auto.arima, decompose)
- **Model evaluation:** `Metrics` (rmse)

## Repository Structure

```
├── Project_MicrosoftStocks.R   # Full analysis: data retrieval, decomposition, forecasting, evaluation
└── README.md
```

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/JacoboC22/Time_SeriesRSB.git
   cd microsoft-stock-forecasting
   ```

2. Install the required R packages:
   ```r
   install.packages(c("quantmod", "forecast", "Metrics"))
   ```

3. Run the script in R or RStudio:
   ```r
   source("Project_MicrosoftStocks.R")
   ```

   > Note: `getSymbols()` requires an internet connection to fetch data from Yahoo Finance.

## Key Insights

- MSFT's closing price shows a **clear upward trend** over 2019-2024, with recurring seasonal fluctuations.
- Multiple forecasting methods (SES, Holt, Holt-Winters, ARIMA) were benchmarked head-to-head instead of relying on a single technique.
- Model comparison via **RMSE on a held-out test set** determined which method — exponential smoothing or ARIMA — best predicts MSFT's future price behavior, avoiding overfitting by validating on unseen data.

## Authors

## License

This project is for academic purposes only. Stock data is sourced from Yahoo Finance via the `quantmod` package and is subject to Yahoo Finance's terms of use.
