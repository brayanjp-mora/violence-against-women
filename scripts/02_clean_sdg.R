# ==============================================================================
# Attitudes and prevalence of intimate partner violence
# Author: Brayan Mora
#
# 02_clean_sdg.R
#
# Purpose: Read raw SDG goal5 data, filter by 5.2.1 sdg indicator, 
#          standardize country codes to iso3n with countrycode package,
#          aggregate to country level
#
# Input:   data/raw/sdg/ 
# Output:  data/processed/sdg_indicator.rds
# ==============================================================================

# Setting up the environment ---------------------------------------------------
library("pacman")
p_load(tidyverse, readxl, janitor, here, countrycode, haven, srvyr)
## SDG Data --------------------------------------------------------------------
sdg_goal5_path <- list.files(here("data", "raw", "sdg"), 
                              pattern = "data-",
                              full.names = TRUE)

goal5_data <- read_xlsx(sdg_goal5_path, sheet = 2) 

## Tidying Data ----------------------------------------------------------------
goal5_data <- goal5_data |> 
  clean_names() |> 
  select(indicator, geo_area_code, geo_area_name, value, age) |> 
  filter(indicator == "5.2.1")

## Cleaning Data ---------------------------------------------------------------
goal5_data <- goal5_data |> 
  # filtering by 15+ matches the open-ended adult age range 
  # of WVS sample (no upper cap) 
  filter(age == "15+")

## Construction ----------------------------------------------------------------
goal5_data <- goal5_data |> 
  mutate(ipv_prevalence_plus15 = as.numeric(value))

 goal5_data <- goal5_data |>   
  # create b_country_apha as iso3c to match wvs dataset
  mutate(b_country_alpha = countrycode(
                            geo_area_code, "un", "iso3c",
                            custom_match = c("412" = "XKX"))) |> 
  drop_na(b_country_alpha)

## Drop non-essential variables ------------------------------------------------
sdg_521_ipv <- goal5_data |> 
  select(-c(age, value, geo_area_code, indicator))

# Save Data --------------------------------------------------------------------
saveRDS(sdg_indicator, here("data", "processed", "sdg_521_ipv.rds"))