# Project: When Diversification Fails
# Step 17: Calculate investment volatility

library(tidyverse)

# Load daily returns
returns <- read.csv("Data/daily_returns.csv")

# Define crisis periods
covid <- returns %>%
  filter(Date >= "2020-02-01",
         Date <= "2020-04-30")

inflation <- returns %>%
  filter(Date >= "2022-01-01",
         Date <= "2022-12-31")

# Function to calculate annualized volatility
calculate_volatility <- function(data) {
  data %>%
    summarise(
      SPY = sd(SPY_return) * sqrt(252),
      IEF = sd(IEF_return) * sqrt(252),
      GLD = sd(GLD_return) * sqrt(252)
    )
}

# Calculate volatility for each crisis
vol_2020 <- calculate_volatility(covid)
vol_2022 <- calculate_volatility(inflation)

# Display results
vol_2020
vol_2022

# Step 18: Calculate maximum drawdown

calculate_drawdown <- function(daily_returns) {
  
  # Growth of $1 invested
  wealth <- cumprod(1 + daily_returns / 100)
  
  # Highest value reached so far
  peak <- cummax(c(1, wealth))[-1]
  
  # Percentage decline from previous peak
  drawdown <- (wealth / peak - 1) * 100
  
  # Largest decline
  min(drawdown)
}

# Calculate maximum drawdown during COVID-19
dd_2020 <- covid %>%
  summarise(
    SPY = calculate_drawdown(SPY_return),
    IEF = calculate_drawdown(IEF_return),
    GLD = calculate_drawdown(GLD_return)
  )

# Calculate maximum drawdown during 2022
dd_2022 <- inflation %>%
  summarise(
    SPY = calculate_drawdown(SPY_return),
    IEF = calculate_drawdown(IEF_return),
    GLD = calculate_drawdown(GLD_return)
  )

# Display results
dd_2020
dd_2022

# Step 19: Combine and save risk statistics

risk_results <- bind_rows(
  data.frame(
    Period = "COVID-19 (2020)",
    Asset = c("SPY", "IEF", "GLD"),
    Volatility = as.numeric(vol_2020[1, ]),
    Max_Drawdown = as.numeric(dd_2020[1, ])
  ),
  data.frame(
    Period = "Inflation Shock (2022)",
    Asset = c("SPY", "IEF", "GLD"),
    Volatility = as.numeric(vol_2022[1, ]),
    Max_Drawdown = as.numeric(dd_2022[1, ])
  )
)

# Display results
print(risk_results)

# Save results
write.csv(
  risk_results,
  "Data/risk_statistics.csv",
  row.names = FALSE
)
