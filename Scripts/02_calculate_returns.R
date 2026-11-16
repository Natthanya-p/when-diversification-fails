# Project: When Diversification Fails
# Step 7: Calculate daily returns

library(tidyverse)

# Load saved historical prices
prices_data <- read.csv("Data/asset_prices.csv")

# Calculate daily percentage returns
returns <- prices_data %>%
  arrange(Date) %>%
  mutate(
    SPY_return = (SPY / lag(SPY) - 1) * 100,
    IEF_return = (IEF / lag(IEF) - 1) * 100,
    GLD_return = (GLD / lag(GLD) - 1) * 100
  ) %>%
  select(Date, SPY_return, IEF_return, GLD_return) %>%
  drop_na()

# Preview the results
head(returns)

# Step 8: Save daily returns

write.csv(
  returns,
  "Data/daily_returns.csv",
  row.names = FALSE
)

# Check the number of observations
nrow(returns)
