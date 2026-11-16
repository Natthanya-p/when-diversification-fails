# Project: When Diversification Fails
# Step 20: Construct a traditional 60/40 portfolio

library(tidyverse)

# Load daily returns
returns <- read.csv("Data/daily_returns.csv")

# Calculate daily portfolio returns
returns <- returns %>%
  mutate(
    Portfolio_60_40 =
      0.60 * SPY_return +
      0.40 * IEF_return
  )

# Display the first six observations
head(
  returns %>%
    select(Date, SPY_return,
           IEF_return, Portfolio_60_40)
)

# Step 21: Stress-test the 60/40 portfolio

# Define crisis periods
covid_portfolio <- returns %>%
  filter(Date >= "2020-02-01",
         Date <= "2020-04-30")

inflation_portfolio <- returns %>%
  filter(Date >= "2022-01-01",
         Date <= "2022-12-31")

# Function to calculate cumulative return
calculate_total_return <- function(x) {
  (prod(1 + x / 100) - 1) * 100
}

# Calculate returns during COVID-19
performance_2020 <- covid_portfolio %>%
  summarise(
    SPY = calculate_total_return(SPY_return),
    IEF = calculate_total_return(IEF_return),
    Portfolio_60_40 =
      calculate_total_return(Portfolio_60_40)
  )

# Calculate returns during 2022
performance_2022 <- inflation_portfolio %>%
  summarise(
    SPY = calculate_total_return(SPY_return),
    IEF = calculate_total_return(IEF_return),
    Portfolio_60_40 =
      calculate_total_return(Portfolio_60_40)
  )

# Display results
performance_2020
performance_2022

# Step 22: Calculate portfolio volatility

# Annualized volatility during COVID-19
portfolio_vol_2020 <- sd(
  covid_portfolio$Portfolio_60_40
) * sqrt(252)

# Annualized volatility during 2022
portfolio_vol_2022 <- sd(
  inflation_portfolio$Portfolio_60_40
) * sqrt(252)

# Display results
portfolio_vol_2020
portfolio_vol_2022

# Step 23: Calculate portfolio maximum drawdown

calculate_drawdown <- function(daily_returns) {
  
  # Growth of $1 invested
  wealth <- cumprod(1 + daily_returns / 100)
  
  # Highest value reached so far
  peak <- cummax(c(1, wealth))[-1]
  
  # Calculate percentage drawdowns
  drawdown <- (wealth / peak - 1) * 100
  
  # Return the worst drawdown
  min(drawdown)
}

# Portfolio drawdown during COVID-19
portfolio_dd_2020 <- calculate_drawdown(
  covid_portfolio$Portfolio_60_40
)

# Portfolio drawdown during 2022
portfolio_dd_2022 <- calculate_drawdown(
  inflation_portfolio$Portfolio_60_40
)

# Display results
portfolio_dd_2020
portfolio_dd_2022

# Step 24: Save portfolio stress-testing results

portfolio_results <- data.frame(
  Period = c("COVID-19 (2020)", "Inflation Shock (2022)"),
  Cumulative_Return = c(
    performance_2020$Portfolio_60_40,
    performance_2022$Portfolio_60_40
  ),
  Annualized_Volatility = c(
    portfolio_vol_2020,
    portfolio_vol_2022
  ),
  Maximum_Drawdown = c(
    portfolio_dd_2020,
    portfolio_dd_2022
  )
)

# Display results
print(portfolio_results)

# Save results
write.csv(
  portfolio_results,
  "Data/portfolio_results.csv",
  row.names = FALSE
)

# Step 25: Construct a portfolio with gold

# Add a 50/30/20 portfolio
returns <- returns %>%
  mutate(
    Portfolio_50_30_20 =
      0.50 * SPY_return +
      0.30 * IEF_return +
      0.20 * GLD_return
  )

# Preview both portfolios
head(
  returns %>%
    select(
      Date,
      Portfolio_60_40,
      Portfolio_50_30_20
    )
)

# Step 26: Compare portfolio cumulative returns

# Select crisis periods with both portfolios
covid_compare <- returns %>%
  filter(Date >= "2020-02-01",
         Date <= "2020-04-30")

inflation_compare <- returns %>%
  filter(Date >= "2022-01-01",
         Date <= "2022-12-31")

# Step 27: Compare portfolio volatility

gold_vol_2020 <- sd(
  covid_compare$Portfolio_50_30_20
) * sqrt(252)

gold_vol_2022 <- sd(
  inflation_compare$Portfolio_50_30_20
) * sqrt(252)

volatility_comparison <- data.frame(
  Period = c("COVID-19 (2020)", "Inflation Shock (2022)"),
  Traditional_60_40 = c(
    portfolio_vol_2020,
    portfolio_vol_2022
  ),
  With_Gold_50_30_20 = c(
    gold_vol_2020,
    gold_vol_2022
  )
)

print(volatility_comparison)

# Step 28: Compare portfolio maximum drawdowns

# Maximum drawdown for gold portfolio in 2020
gold_dd_2020 <- calculate_drawdown(
  covid_compare$Portfolio_50_30_20
)

# Maximum drawdown for gold portfolio in 2022
gold_dd_2022 <- calculate_drawdown(
  inflation_compare$Portfolio_50_30_20
)

# Compare both portfolios
drawdown_comparison <- data.frame(
  Period = c("COVID-19 (2020)", "Inflation Shock (2022)"),
  Traditional_60_40 = c(
    portfolio_dd_2020,
    portfolio_dd_2022
  ),
  With_Gold_50_30_20 = c(
    gold_dd_2020,
    gold_dd_2022
  )
)

print(drawdown_comparison)

# Step 29: Save complete portfolio comparison

portfolio_comparison <- data.frame(
  Period = rep(
    c("COVID-19 (2020)", "Inflation Shock (2022)"),
    each = 2
  ),
  Portfolio = rep(
    c("Traditional 60/40", "With Gold 50/30/20"),
    times = 2
  ),
  Cumulative_Return = c(
    comparison_2020$Portfolio_60_40,
    comparison_2020$Portfolio_50_30_20,
    comparison_2022$Portfolio_60_40,
    comparison_2022$Portfolio_50_30_20
  ),
  Annualized_Volatility = c(
    portfolio_vol_2020,
    gold_vol_2020,
    portfolio_vol_2022,
    gold_vol_2022
  ),
  Maximum_Drawdown = c(
    portfolio_dd_2020,
    gold_dd_2020,
    portfolio_dd_2022,
    gold_dd_2022
  )
)

# Display results
print(portfolio_comparison)

# Save results
write.csv(
  portfolio_comparison,
  "Data/portfolio_comparison.csv",
  row.names = FALSE
)
