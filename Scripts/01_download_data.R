
# Project 2: When Diversification Fails
# Step 3: Install required packages

install.packages(c(
  "quantmod",
  "tidyverse",
  "lubridate"
))


# Step 4: Download historical financial data

library(quantmod)
library(tidyverse)
library(lubridate)

# Assets we want to study
tickers <- c("SPY", "IEF", "GLD")

# Download daily market data
getSymbols(
  tickers,
  src = "yahoo",
  from = "2015-01-01",
  to = "2026-11-01"
)

# Combine adjusted closing prices
prices <- merge(
  Ad(SPY),
  Ad(IEF),
  Ad(GLD)
)

colnames(prices) <- tickers

# Display the first six observations
head(prices)
