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
# Output:  data/processed/ipv_country.rds
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
  clean_names()

