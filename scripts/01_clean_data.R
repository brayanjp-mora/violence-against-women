# ==============================================================================
# Attitudes and prevalence of intimate partner violence
# Author: Brayan Mora
#
# 01_clean_data.R
#
# Purpose: Read raw WVS Wave 7 and SDG 5.2.1 data, filter to valid responses,
#          aggregate WVS to country level, and merge into an analysis-ready
#          dataset.
#
# Input:   data/raw/wvs/WVS_*.rds
#          data/raw/sdg/  (or pulled from the UN SDG API)
# Output:  data/processed/ipv_country.rds
# ==============================================================================

# Setting up the environment ---------------------------------------------------
library("pacman")
p_load(tidyverse, readxl, janitor, here, countrycode, haven)


# Data -------------------------------------------------------------------------
## SDG Data --------------------------------------------------------------------
sdg_goal5_path <- list.files(here("data", "raw", "sdg"), 
                              pattern = "data-",
                              full.names = TRUE)

goal5_data <- read_xlsx(sdg_goal5_path, sheet = 2) 
## WVS Data --------------------------------------------------------------------
wvs_path <- list.files(here("data", "raw", "wvs"), 
                        pattern = "WVS_", 
                        full.names = TRUE)

wvs_data <- read_rds(wvs_path)


# Clean Data ===================================================================
## WVS DATA --------------------------------------------------------------------
wvs_data <- wvs_data |> 
  clean_names() 

