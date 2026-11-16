# Project: When Diversification Fails
# Step 13: Correlation analysis

library(tidyverse)

# Load daily returns
returns <- read.csv("Data/daily_returns.csv")

# COVID-19 crisis period
covid <- returns %>%
  filter(Date >= "2020-02-01",
         Date <= "2020-04-30")

# 2022 inflation shock period
inflation <- returns %>%
  filter(Date >= "2022-01-01",
         Date <= "2022-12-31")

# Calculate stock-bond correlations
cor_2020 <- cor(covid$SPY_return,
                covid$IEF_return)

cor_2022 <- cor(inflation$SPY_return,
                inflation$IEF_return)

# Display results
cor_2020
cor_2022

# Step 14: Save stock-bond correlation results

correlation_results <- data.frame(
  Period = c("COVID-19 (2020)", "Inflation Shock (2022)"),
  SPY_IEF_Correlation = c(cor_2020, cor_2022)
)

# Display results
print(correlation_results)

# Save results
write.csv(
  correlation_results,
  "Data/correlation_results.csv",
  row.names = FALSE
)
