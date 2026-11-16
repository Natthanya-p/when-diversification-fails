# Project: When Diversification Fails
# Step 15: 60-day rolling stock-bond correlation

library(tidyverse)

# Load daily returns
returns <- read.csv("Data/daily_returns.csv")

# Calculate rolling correlations
rolling_corr <- returns %>%
  mutate(
    Date = as.Date(Date),
    Rolling_Correlation = sapply(
      seq_len(n()),
      function(i) {
        if (i < 60) {
          return(NA_real_)
        }
        
        cor(
          SPY_return[(i - 59):i],
          IEF_return[(i - 59):i]
        )
      }
    )
  ) %>%
  drop_na(Rolling_Correlation)

# Create visualization
ggplot(rolling_corr,
       aes(x = Date, y = Rolling_Correlation)) +
  geom_line(color = "steelblue", linewidth = 0.7) +
  geom_hline(
    yintercept = 0,
    linetype = "dashed",
    color = "red"
  ) +
  labs(
    title = "When Does Stock-Bond Diversification Break Down?",
    subtitle = "60-Day Rolling Correlation: SPY vs IEF",
    x = "Date",
    y = "Rolling Correlation"
  ) +
  theme_minimal()

# Step 16: Save rolling correlation graph

ggsave(
  filename = "Figures/rolling_correlation.png",
  width = 10,
  height = 6,
  dpi = 300
)
