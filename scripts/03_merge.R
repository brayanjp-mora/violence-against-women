# ==============================================================================
# Attitudes and prevalence of intimate partner violence
# Author: Brayan Mora
#
# 03_merge.R
#
# Purpose: Merge processed dataset, rename variables, organize variables order.
#
# Input:   data/processed/sdg_521_ipv.rds
#          data/processed/wvs_country.rds 
# Output:  data/processed/country_analysis.rds
# ==============================================================================
# Setting up the environment ---------------------------------------------------
library("tidyverse")
library("here")

# Load data --------------------------------------------------------------------
sdg_521_ipv <- read_rds(here("data", "processed", "sdg_521_ipv.rds"))
wvs_country <- read_rds(here("data", "processed", "wvs_country.rds"))

# Merge data -------------------------------------------------------------------
analysis_country <- inner_join(wvs_country, sdg_521_ipv, by = "b_country_alpha") |> 
  rename(iso3 = b_country_alpha, country = geo_area_name) |> 
  relocate(country, .before = iso3)
# List of countries that exists in wvs but not in sdg (excluded):
  # MYS, IRQ, LBN, MAC, RUS, UZB, TWN, IRN, LBY, NIC, AND, PRI

# Save merged data -------------------------------------------------------------
saveRDS(analysis_country, here("data", "processed", "analysis_country.rds"))