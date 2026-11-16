# When Diversification Fails: Safe-Haven Assets During Financial Crises

## Project Overview

The purpose of this project is to evaluate the extent to which the efficiency of portfolio diversification changes during financial crises. The comparison will be made between the market crash caused by the coronavirus pandemic of 2020 and the financial crisis of 2022 caused by high inflation.

## Research Question

How does portfolio diversification perform during different financial crises, and can including gold improve portfolio resilience?

## Data and Methodology

- **Data source:** Yahoo Finance, accessed using R and the `quantmod` package
- **Assets:** SPY (U.S. equities), IEF (U.S. Treasury bonds), GLD (gold)
- **Data period:** January 2015 – October 2026
- **Crisis periods:** February–April 2020 and January–December 2022
- **Methods:** Daily returns, correlation analysis, 60-day rolling correlation, cumulative returns, annualized volatility, and maximum drawdown

Two hypothetical portfolios are compared:

- **Traditional:** 60% SPY, 40% IEF
- **Alternative:** 50% SPY, 30% IEF, 20% GLD

Portfolio weights are assumed to be rebalanced daily, excluding transaction costs and taxes.

## Key Findings

- Stock-bond correlation changed from approximately **-0.55 in 2020** to **+0.19 in 2022**.
- The alternative portfolio experienced smaller cumulative losses during both crises.
- The alternative portfolio also exhibited lower annualized volatility and smaller maximum drawdowns in both periods.
- Diversification effectiveness depends on economic conditions. The improved performance cannot be attributed to gold alone because the portfolio weights also differ.

## Full Research Report

The complete analysis, including methodology, results, graphs, and discussion, is available here [View the Full Research Report](https://natthanya-p.github.io/when-diversification-fails/Report/when_diversification_fails.html).

## Tools and Skills

R, RStudio, tidyverse, quantmod, ggplot2, financial data analysis, portfolio risk measurement, and data visualization.

## Project Structure

- `Scripts/` — R scripts for data collection and analysis
- `Data/` — Historical prices, returns, and calculated results
- `Figures/` — Visualizations and graphs
- `Report/` — R Markdown source and HTML research report

## Limitations

The analysis focuses on two historical crises and two hypothetical portfolios. Results assume daily rebalancing without transaction costs or taxes. Historical performance does not guarantee future results.
