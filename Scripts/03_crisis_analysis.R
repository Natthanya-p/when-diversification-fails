# Project: When Diversification Fails
# Step 9: COVID-19 crisis analysis

library(tidyverse)

# Load daily returns
returns <- read.csv("Data/daily_returns.csv")

# Select the COVID-19 crisis period
covid_returns <- returns %>%
  filter(Date >= "2020-02-01",
         Date <= "2020-04-30")

# Convert returns into growth of $100
covid_growth <- covid_returns %>%
  mutate(
    SPY = 100 * cumprod(1 + SPY_return / 100),
    IEF = 100 * cumprod(1 + IEF_return / 100),
    GLD = 100 * cumprod(1 + GLD_return / 100)
  ) %>%
  select(Date, SPY, IEF, GLD) %>%
  pivot_longer(
    cols = c(SPY, IEF, GLD),
    names_to = "Asset",
    values_to = "Investment_Value"
  )

# Create the visualization
ggplot(covid_growth,
       aes(x = as.Date(Date),
           y = Investment_Value,
           color = Asset)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Did Safe-Haven Assets Protect Investors During COVID-19?",
    subtitle = "Growth of $100 | February-April 2020",
    x = "Date",
    y = "Investment Value ($)",
    color = "Asset"
  ) +
  theme_minimal()

# Step 10: Save COVID-19 visualization

ggsave(
  filename = "Figures/covid_crisis.png",
  width = 10,
  height = 6,
  dpi = 300
)

# Step 11: Analyze the 2022 inflation shock

# Select the 2022 period
inflation_returns <- returns %>%
  filter(Date >= "2022-01-01",
         Date <= "2022-12-31")

# Calculate growth of $100
inflation_growth <- inflation_returns %>%
  mutate(
    SPY = 100 * cumprod(1 + SPY_return / 100),
    IEF = 100 * cumprod(1 + IEF_return / 100),
    GLD = 100 * cumprod(1 + GLD_return / 100)
  ) %>%
  select(Date, SPY, IEF, GLD) %>%
  pivot_longer(
    cols = c(SPY, IEF, GLD),
    names_to = "Asset",
    values_to = "Investment_Value"
  )

# Create the graph
ggplot(inflation_growth,
       aes(x = as.Date(Date),
           y = Investment_Value,
           color = Asset)) +
  geom_line(linewidth = 1) +
  labs(
    title = "When Diversification Fails: The 2022 Inflation Shock",
    subtitle = "Growth of $100 | January-December 2022",
    x = "Date",
    y = "Investment Value ($)",
    color = "Asset"
  ) +
  theme_minimal()

# Step 12: Save 2022 inflation shock graph

ggsave(
  filename = "Figures/inflation_2022.png",
  width = 10,
  height = 6,
  dpi = 300
)
