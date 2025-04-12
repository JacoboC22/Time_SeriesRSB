This project performs a comprehensive time series analysis of Microsoft Corporation's stock data (Ticker: MSFT) over the period from January 2019 to December 2024. Developed using R, the analysis focuses on exploring historical trends, seasonal patterns, and forecasting future values using multiple time series modeling techniques.

Using the quantmod package, monthly stock data was pulled from Yahoo Finance, including Open, High, Low, Close, and Volume values. Each component was visualized to assess patterns and behaviors. Time series decomposition was applied to better understand trends and seasonal components.

Techniques Applied
Visualization & Decomposition:
Time series decomposition of Open, High, Low, and Close prices was conducted to separate trend, seasonality, and random components.

Forecasting Models:

- Simple Exponential Smoothing (SES)

- Holt’s Linear Trend Method

- Holt-Winters (Additive & Multiplicative)
  
- ARIMA (Auto-Regressive Integrated Moving Average)

Model Evaluation:
A training and testing split (75/25) was used to compare model performance. Models were evaluated using Root Mean Square Error (RMSE), and the best-performing method was selected based on forecast accuracy.

Results
The script evaluates and compares forecasting models, highlighting the most effective method for predicting future stock behavior. The final output provides a recommendation between Holt-Winters and ARIMA, based on their relative RMSE scores.

Tools & Libraries
quantmod: Data acquisition and financial visualization

forecast: Time series modeling and forecasting

Metrics: RMSE calculation for model comparison
