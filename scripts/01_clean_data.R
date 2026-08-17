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
install.packages("pacman")
library("pacman")
p_load(tidyverse, readxl, janitor, here, countrycode, haven, srvyr)


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


# WVS DATA =====================================================================
## Tidying Data ----------------------------------------------------------------
wvs_data <- wvs_data |> 
  clean_names() |> 
  select(b_country_alpha, w_weight, q189, q260)

## Cleaning Data ---------------------------------------------------------------
wvs_data <- wvs_data |> 
  # Drop Northern Ireland (NIR) to prevent overrepresentation bias;
  # Combining NIR with GBR requires complex, non-standard weight adjustments.
  filter(b_country_alpha != "NIR")

### cleaning sex variable
wvs_data <- wvs_data |>  
  # keep only male and female to avoid noise of other responses
  filter(q260_num %in% c(1,2))

## Construction ----------------------------------------------------------------

### construct the attitude variable from Q189
wvs_data <- wvs_data |> 
  # Drop haven metadata to prevent errors later
  mutate(q189_num = zap_labels(q189)) |> 
  # recode to binary: 1 = "never justifiable", 2–10 = any justification
  mutate( 
    justif = case_when(
      q189_num == 1 ~ 0, 
      between(q189_num, 2, 10) ~ 1,
      TRUE ~ NA
  )) 

### Aggregate to country level ---------------------------------------------------
wvs_country <- wvs_data |>
  # drop NA values to avoid missing values survey design errors 
  # (see construction section)
  drop_na(justif) |>
  as_survey_design(weights = w_weight) |>
  # weighted % who consider wife-beating justifiable, per country
  group_by(b_country_alpha) |>
  summarise(pct_justif = survey_mean(justif, proportion = TRUE) * 100) |> 
  arrange(desc(pct_justif))
