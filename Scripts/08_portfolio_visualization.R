# Project: When Diversification Fails
# Step 30: Portfolio performance visualization

library(tidyverse)

# Load daily returns
returns <- read.csv("Data/daily_returns.csv")

# Calculate returns for both portfolios
returns <- returns %>%
  mutate(
    Portfolio_60_40 =
      0.60 * SPY_return +
      0.40 * IEF_return,
    
    Portfolio_50_30_20 =
      0.50 * SPY_return +
      0.30 * IEF_return +
      0.20 * GLD_return
  )

# Select both crisis periods
crisis_data <- returns %>%
  mutate(
    Period = case_when(
      Date >= "2020-02-01" &
        Date <= "2020-04-30" ~ "COVID-19 (2020)",
      
      Date >= "2022-01-01" &
        Date <= "2022-12-31" ~ "Inflation Shock (2022)",
      
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(Period))

# Calculate growth of $100 for each portfolio
portfolio_growth <- crisis_data %>%
  group_by(Period) %>%
  arrange(Date, .by_group = TRUE) %>%
  mutate(
    Traditional_60_40 =
      100 * cumprod(1 + Portfolio_60_40 / 100),
    
    With_Gold_50_30_20 =
      100 * cumprod(1 + Portfolio_50_30_20 / 100)
  ) %>%
  ungroup() %>%
  select(Date, Period,
         Traditional_60_40,
         With_Gold_50_30_20) %>%
  pivot_longer(
    cols = c(Traditional_60_40, With_Gold_50_30_20),
    names_to = "Portfolio",
    values_to = "Investment_Value"
  )

# Plot portfolio performance
portfolio_plot <- ggplot(
  portfolio_growth,
  aes(
    x = as.Date(Date),
    y = Investment_Value,
    color = Portfolio
  )
) +
  geom_line(linewidth = 1) +
  facet_wrap(~ Period, scales = "free_x", ncol = 1) +
  labs(
    title = "Does Adding Gold Improve Portfolio Resilience?",
    subtitle = "Growth of $100 During Two Financial Crises",
    x = "Date",
    y = "Investment Value ($)",
    color = "Portfolio"
  ) +
  theme_minimal()

# Step 32: Save portfolio comparison graph

ggsave(
  filename = "Figures/portfolio_crisis_comparison.png",
  plot = portfolio_plot,
  width = 11,
  height = 9,
  dpi = 300
)
