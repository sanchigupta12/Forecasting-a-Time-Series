# Forecasting a Time Series: A Comparative Analysis of Stock and Commodity Prices

## Project Overview

This project involves a detailed time series analysis of stock prices for Honeywell International Inc. (HON) and Apple Inc. (AAPL), as well as dry wine prices. The analysis leverages Excel and R to perform short-term forecasting using exponential smoothing techniques and ARIMA models. The goal is to identify trends, seasonality, and volatility in the datasets to generate accurate forecasts and provide actionable insights for investors and analysts.

## Contents

- **Introduction**: Overview of time series forecasting, including the significance of seasonality, trends, and volatility in stock and commodity prices.
- **Analysis**:
  - **Part 1: Short-term Forecasting using Excel**:
    - **Time Series Analysis of AAPL and HON Stocks**: Comparative analysis of stock prices using line plots.
    - **Exponential Smoothing Application**: Forecasting using different alpha values and evaluating performance with MAD and MAPE.
    - **Adjusted Exponential Smoothing Forecast**: Further refinement using beta values.
  - **Part 2: Time Series Analysis using R**:
    - **ARIMA Model Fitting**: Application of ARIMA models to AAPL and HON stock prices and the dry wine dataset.
    - **Stationarity Testing**: Utilizing the Augmented Dickey-Fuller (ADF) test.
    - **Auto-ARIMA Model**: Automated model selection for forecasting.
    - **Comparison of Forecasting Methods**: Evaluating the effectiveness of ARIMA models for stocks versus commodity prices.
- **Conclusion**: Summary of findings and the implications for future time series forecasting in enterprise analytics.

## Key Findings

- **Exponential Smoothing**: For both AAPL and HON, the optimal alpha value (α=0.175) provided the most accurate forecasts, as indicated by the lowest MAD and MAPE values.
- **ARIMA Models**: The ARIMA(0,1,0) model with drift was more suitable for AAPL due to its upward trend, whereas the ARIMA(0,1,0) without drift was better for HON, which showed less clear trend behavior.
- **Seasonal ARIMA (SARIMA) for Dry Wine Prices**: The dry wine dataset exhibited strong seasonality, making SARIMA the preferred method for accurate forecasting.

## Tools & Techniques

- **Excel**: Used for initial time series analysis and exponential smoothing forecasts.
- **R**: Applied ARIMA models using the `quantmod` and `tseries` packages, including the `auto.arima()` function for model selection.
- **Statistical Analysis**: MAD, MAPE, and ARIMA modeling were employed to assess the accuracy and reliability of the forecasts.

## References

1. Losada, L. (2022, March 30). Time Series Analysis with Auto.Arima in R - Towards Data Science. Medium. https://towardsdatascience.com/time-series-analysis-with-auto-arima-in-r-2b220b20e8ab
2. Introduction to ARIMA: Nonseasonal Models. (n.d.). https://people.duke.edu/~rnau/411arim.htm
