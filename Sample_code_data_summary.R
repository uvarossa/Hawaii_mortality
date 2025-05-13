############
### 2014 ###
############


# This is a sample code of how we cleaned and summarized overdose and suicide numbers accross counties


# 2014 raw data cleaning 


rm(list = ls())
#rcode - https://stackoverflow.com/questions/70657014/how-do-i-import-a-file-into-r-with-extension-dusmcpub

file_path <- "/User/Data2014"
file.exists(file_path)

# Check if the file exists
if (!file.exists(file_path)) {
  stop("The file does not exist at the specified path.")
}

map <- data.frame(widths=c(18,  #cols 1-19 - blank1
                           1, #19 - res_occur_same
                           1, #20 - res_status
                           2, #21-22 - state_occurrence_fips
                           3, #23-25 - county_occurrence_fips
                           2, #26-27 - expanded_occurrence_state
                           1, #28 - county_occurrence_popsize
                           2, #29-30 - state_residence_fips
                           2, #31-32 - blank2
                           2, #33-34 - state_residence_fips_code
                           3, #35-37 - county_residence_fips
                           5, #38-42 - city_residence_fips
                           1, #43 - city_residence_popsize
                           1, #44 - met/nonmet_county
                           2, #45-46 - state_expanded
                           8, #47-54 - reserved1
                           2, #55-56 - state_birth_fips
                           2, #57-58 - reserved2
                           2, #59-60 - "statecounty_birth_recode
                           2, #61-62 - educ_decendent_old,  
                           1, #63 - educ_decendent_new, 
                           1, #64 - educ_flag,                         
                           2, #65-66 - death_month
                           2, #67-68 - blank3
                           1, #69 - sex
                           4, #70-73 - "age_detail"
                           1, #74 - "age_substitution"
                           2, #75-76 - "age-recode_52"
                           2, #77-78 - "age_recode_27"
                           2, #79-80 - "age_recode_12"
                           2, #81-82 - "infant_age_recode"
                           1, #83 - "place_of_death"
                           1, #84 - marital_status
                           1, #85 - death_day
                           16, #86-101 - blank4
                           4, #102-105 - current_year
                           1, #106 - work_injury
                           1, #107 - death_manner
                           1, #108 - disposition
                           1, #109 - autopsy
                           1, #110 - certifier
                           31, #111-141 -blank5
                           1, #142 - tobacco
                           1, #143 - pregnancy
                           1, #144 - activity
                           1, #145 - place_injured
                           4, #146-149 - icd_cause_of_death
                           3, #150-152 - cause_recode358
                           1, #153 - blank6 
                           3, #154-156 - cause_recode113
                           3, #157-159 - infant_cause_recode130
                           2, #160-161 - cause_recode39
                           1, #162 - blank7
                           2, #163-164 - num_entity_axis
                           7, #"cond1", #165-171
                           7, #"cond2", #172-178
                           7, #"cond3", #179-185
                           7, #"cond4", #186-192
                           7, #"cond5", #193-199
                           7, #"cond6", #200-206
                           7, #"cond7", #207-213
                           7, #"cond8", #214-220
                           7, # "cond9", #221-227
                           7, #"cond10", #228-234
                           7, #"cond11", #235-241
                           7, #"cond12", #242-248
                           7, #"cond13", #249-255
                           7, #"cond14", #256-262
                           7, #"cond15", #263-269
                           7, #"cond16", #270-276
                           7, #"cond17", #277-283
                           7, #"cond18", #284-290
                           7, #"cond19", #291-297 
                           7, #"cond20", #298-304
                           36, #305-340 - blank8
                           2, #341-342 - num_entity_axis
                           1, #343 - blank9
                           5, #"acond1", #344-348
                           5, #"acond2", #349-353
                           5, #"acond3", #354-358
                           5, #"acond4", #359-363
                           5, #"acond5", #364-368 
                           5, #"acond6", #369-373
                           5, #"acond7", #374-378
                           5, #"acond8", #379-383
                           5, #"acond9", #384-388
                           5, #"acond10", #389-393
                           5, #"acond11", #394-398
                           5, #"acond12", #399-403
                           5, #"acond13", #404-408
                           5, #"acond14", #409-413
                           5, #"acond15", #414-418
                           5, #"acond16", #419-433
                           5, #"acond17", #424-428
                           5, #"acond18", #429-433
                           5, #"acond19", #434-438
                           5, #"acond20", #439-443
                           1, #444 - blank10 
                           2, #445-446 - race 
                           1, #447 - bridged_race_flag
                           1, #448 - race_imp_flag
                           1, #449 - race_recode3
                           1, #450 - race_recode5
                           33, #451-483 - blank11
                           3, #484-486 - hisp
                           1, #487 - blank12 (until 2021)
                           1, #488 - hisp_race (until 2020)
                           2, #489-490 race_recode
                           315, #491-805 blank13
                           2, #806-809 occupation
                           2, #810-811 occupation_recode
                           4, #812-815 industry
                           2)) #816-817 industry_recode


#Set column names 
map$cn <- c("blank1", # cols 1-18
            "res_occur_same", # col 19
            "res_status",  #20
            "state_occurrence_fips", # 21-22
            "county_occurrence_fips", #23-25
            "expanded_occurrence_state", #26-27
            "county_occurrence_popsize", #28
            "state_residence_fips", #29-30
            "blank2", #31-32
            "state_residence_fips_code", #33-34
            "county_residence_fips", #35-37 
            "city_residence_fips", # 38-42
            "city_residence_popsize", #43
            "met_nonmet_county", #44
            "state_expanded", #45-46
            "reserved1", #47-54
            "state_birth_fips",#55-56
            "reserved2", #57-58
            "statecounty_birth_recode", #59-60
            "educ_decendent_old", #61-62  
            "educ_decendent_new", #63
            "educ_flag", #64
            "death_month", #65-66
            "blank3", #67-68
            "sex", #69
            "age_detail", #70-73
            "age_substitution", #74
            "age_recode_52", #75-76
            "age_recode_27", #77-78
            "age_recode_12", #79-80
            "infant_age_recode", #81-82
            "place_of_death", #83
            "marital_status", #84
            "death_day", #85
            "blank4", #86-101
            "current_year", #102-105 
            "work_injury", #106
            "death_manner", #107
            "disposition", #108
            "autopsy", #109
            "certifier", #110
            "blank5", #111-141
            "tobacco", #142
            "pregnancy", #143
            "activity", #144
            "place_injured", #145
            "icd_cause_of_death", #146-149
            "cause_recode358", #150-152
            "blank6", #153
            "cause_recode113", #154-156 
            "infant_cause_recode130", #157-159
            "cause_recode39", #160-161
            "blank7", #162
            "num_entity_axis", #163-164
            "cond1", #165-171
            "cond2", #172-178
            "cond3", #179-185
            "cond4", #186-192
            "cond5", #193-199
            "cond6", #200-206
            "cond7", #207-213
            "cond8", #214-220
            "cond9", #221-227
            "cond10", #228-234
            "cond11", #235-241
            "cond12", #242-248
            "cond13", #249-255
            "cond14", #256-262
            "cond15", #263-269
            "cond16", #270-276
            "cond17", #277-283
            "cond18", #284-290
            "cond19", #291-297 
            "cond20", #298-304
            "blank8", #305-340 
            "num_rec_axis_cond", #341-342
            "blank9", #343
            "acond1", #344-348
            "acond2", #349-353
            "acond3", #349-353
            "acond4", #359-363
            "acond5", #364-368 
            "acond6", #369-373
            "acond7", #374-378
            "acond8", #379-383
            "acond9", #384-388
            "acond10", #389-393
            "acond11", #394-398
            "acond12", #394-398
            "acond13", #404-408
            "acond14", #409-413
            "acond15", #414-418
            "acond16", #419-433
            "acond17", #424-428
            "acond18", #429-433
            "acond19", #434-438
            "acond20", #439-443
            "blank10", #444
            "race", #445-446
            "bridged_race_flag", #447
            "race_imp_flag", #448
            "race_recode3", #449
            "race_recode5", #450
            "blank11", #451-484 
            "hisp", #484-486
            "blank12", #487
            "hisp_race", #488
            "race_recode", #489-490 
            "blank13", #491-805 
            "occupation", #806-809 
            "occupation_recode", #810-811 
            "industry", #812-815 
            "industry_recode") #816-817 

# Load required library
if (!requireNamespace("readr", quietly = TRUE)) {
  install.packages("readr")
}

library(readr)

#because I am getting a parsing error in some columns, I am forsing to read all data as character

data_2014 <- read_fwf(
  file_path,
  fwf_widths(map$widths, col_names = map$cn),
  col_types = cols(.default = "c")  # Reading everything as character
)


#====================================#
### summarizing suicides by county ###
#====================================#

# loading necessary packages
library(dplyr)
library(stringr)

# preparing data for summarizing
dt_14 <- data_2014 %>% 
  mutate(
    current_year = as.numeric(current_year),
    death_month = as.numeric(death_month),
    age_detail = as.numeric(age_detail),
    race_recode = as.numeric(race_recode),
    race_recode5 = as.numeric(race_recode5),
    hisp = as.numeric(hisp)
  ) %>% 
  # filtering only those aged more than 1 year and unknown age
  filter(str_starts(as.character(age_detail), "1") | str_starts(as.character(age_detail), "9")) %>% 
  filter(
    icd_cause_of_death == "U03" |
      icd_cause_of_death == "Y870" |
      # Matches X60–X84
      str_detect(icd_cause_of_death, "^X(6[0-9]|7[0-9]|8[0-4])")  
  ) %>%
  select(state_occurrence_fips,
         county_occurrence_fips,
         current_year,
         death_month,
         age_detail,
         sex,
         icd_cause_of_death,
         bridged_race_flag,
         race_recode5,
         race_recode,
         hisp         
  ) %>% 
  mutate(
    age_in_years = case_when(
      # age is missing if it is 9999
      !str_starts(as.character(age_detail), "1") ~ NA_real_, 
      # age is missing if it is 1999
      as.character(age_detail) == "1999" ~ NA_real_,
      # age is recoded to numerical number in years
      str_starts(as.character(age_detail), "1") ~ as.numeric(str_sub(as.character(age_detail), 2))  # Condition 3
    ),
    age_cat = case_when(
      # <10
      age_in_years < 10 ~ 1,
      # 10–14
      age_in_years >= 10 & age_in_years <= 14 ~ 2,
      # 15–24
      age_in_years >= 15 & age_in_years <= 24 ~ 3,
      # 25–44
      age_in_years >= 25 & age_in_years <= 44 ~ 4,
      # 45–64
      age_in_years >= 45 & age_in_years <= 64 ~ 5,
      # 65–74
      age_in_years >= 65 & age_in_years <= 74 ~ 6,
      # 75 and older
      age_in_years >= 75 ~ 7,
      TRUE ~ NA_real_    
    ),
    race_cat = case_when(
      # White
      race_recode == 01 ~ 1,
      # Black
      race_recode == 02 ~ 2,
      # American Indian or Alaska Native
      race_recode == 03 ~ 3,  
      # Asian
      race_recode >= 04 & race_recode <= 10 ~ 4,
      # Native Hawaiian or Pacific Islander
      race_recode >= 11 & race_recode <= 14 ~ 5,  
      # Multiracial
      race_recode >= 15 & race_recode <= 40 ~ 6,
      # Unknown
      race_recode == 99 ~ 99,
      # If there are unexpected values
      TRUE ~ NA_real_  
    ),
    hispanic = case_when(
      # Non-Hispanic
      hisp >= 100 & hisp <= 199 ~ 0,
      # Hispanic
      hisp >= 200 & hisp <= 299 ~ 1,
      # Unknown
      hisp >= 996 & hisp <= 999 ~ 99,  
      # Catch any unexpected values
      TRUE ~ NA_real_   
    ),
    sex = case_when(
      sex == "F" ~ 0,
      sex == "M" ~ 1,
      TRUE ~ NA_real_
    )) 



dt14_summary <- dt_14 %>% 
  rename(
    state = state_occurrence_fips,
    county = county_occurrence_fips,
    year = current_year,
    month = death_month
  ) %>%
  group_by(state, county, year, month, age_cat, sex, race_cat, hispanic) %>%
  summarise(events = n(), .groups = "drop")



#====================================#
### summarizing overdoses by county ##
#====================================#



#alldrugs
dt_14_alldrugs <- data_2014 %>% 
  mutate(
    current_year = as.numeric(current_year),
    death_month = as.numeric(death_month),
    age_detail = as.numeric(age_detail),
    race_recode = as.numeric(race_recode),
    race_recode5 = as.numeric(race_recode5),
    hisp = as.numeric(hisp)
  ) %>% 
  # filtering only those aged more than 1 year and unknown age
  filter(str_starts(as.character(age_detail), "1") | str_starts(as.character(age_detail), "9")) %>% 
  filter(
    icd_cause_of_death == "X85" |
      # Matches X40–X44
      str_detect(icd_cause_of_death, "^X(4[0-4])") |
      # Matches X60–X64
      str_detect(icd_cause_of_death, "^X(6[0-4])") |
      # Matches Y10-Y14
      str_detect(icd_cause_of_death, "^Y(1[0-4])")
  ) %>%
  select(state_occurrence_fips,
         county_occurrence_fips, 
         current_year,
         death_month,
         age_detail,
         sex,
         icd_cause_of_death,
         bridged_race_flag,
         race_recode,
         hisp,
         acond1,
         acond2,
         acond3,
         acond4,
         acond5,
         acond6,
         acond7,
         acond8,
         acond9,
         acond10,
         acond11,
         acond12,
         acond13,
         acond14,
         acond15,
         acond16,
         acond17,
         acond18,
         acond19,
         acond20
  ) %>% 
  mutate(
    age_in_years = case_when(
      # age is missing if it is 9999
      !str_starts(as.character(age_detail), "1") ~ NA_real_, 
      # age is missing if it is 1999
      as.character(age_detail) == "1999" ~ NA_real_,
      # age is recoded to numerical number in years
      str_starts(as.character(age_detail), "1") ~ as.numeric(str_sub(as.character(age_detail), 2))  # Condition 3
    ),
    age_cat = case_when(
      # <10
      age_in_years < 10 ~ 1,
      # 10–14
      age_in_years >= 10 & age_in_years <= 14 ~ 2,
      # 15–24
      age_in_years >= 15 & age_in_years <= 24 ~ 3,
      # 25–44
      age_in_years >= 25 & age_in_years <= 44 ~ 4,
      # 45–64
      age_in_years >= 45 & age_in_years <= 64 ~ 5,
      # 65–74
      age_in_years >= 65 & age_in_years <= 74 ~ 6,
      # 75 and older
      age_in_years >= 75 ~ 7,
      TRUE ~ NA_real_    
    ),
    race_cat = case_when(
      # White
      race_recode == 01 ~ 1,
      # Black
      race_recode == 02 ~ 2,
      # American Indian or Alaska Native
      race_recode == 03 ~ 3,  
      # Asian
      race_recode >= 04 & race_recode <= 10 ~ 4,
      # Native Hawaiian or Pacific Islander
      race_recode >= 11 & race_recode <= 14 ~ 5,  
      # Multiracial
      race_recode >= 15 & race_recode <= 40 ~ 6,
      # Unknown
      race_recode == 99 ~ 99,
      # If there are unexpected values
      TRUE ~ NA_real_  
    ),
    hispanic = case_when(
      # Non-Hispanic
      hisp >= 100 & hisp <= 199 ~ 0,
      # Hispanic
      hisp >= 200 & hisp <= 299 ~ 1,
      # Unknown
      hisp >= 996 & hisp <= 999 ~ 99,  
      # Catch any unexpected values
      TRUE ~ NA_real_   
    ),
    sex = case_when(
      sex == "F" ~ 0,
      sex == "M" ~ 1,
      TRUE ~ NA_real_
    )) 

#check states
dt_14_alldrugs <- dt_14_alldrugs[order(dt_14_alldrugs$state_occurrence_fips), ]
unique(dt_14_alldrugs$state_occurrence_fips) # dc is the only non-state

state_acronyms_fips <- data.frame(
  state_occurrence_fips = c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                            "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
                            "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
                            "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
                            "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC"),
  state_fips = c("01", "02", "04", "05", "06", "08", "09", "10", "12", "13",
                 "15", "16", "17", "18", "19", "20", "21", "22", "23", "24",
                 "25", "26", "27", "28", "29", "30", "31", "32", "33", "34",
                 "35", "36", "37", "38", "39", "40", "41", "42", "44", "45",
                 "46", "47", "48", "49", "50", "51", "53", "54", "55", "56", "11")
)  

dt_14_alldrugs <- merge(state_acronyms_fips, dt_14_alldrugs, by = "state_occurrence_fips")

dt_14_alldrugs$fips <- paste0(
  as.character(dt_14_alldrugs$state_fips),
  as.character(dt_14_alldrugs$county_occurrence_fips)
)
dt_14_alldrugs$fips <- as.numeric(dt_14_alldrugs$fips)

dt14_alldrugs_summary <- dt_14_alldrugs %>% 
  rename(
    state = state_occurrence_fips,
    county = county_occurrence_fips,
    year = current_year,
    month = death_month
  ) %>%
  group_by(fips, year, month, age_cat, sex, race_cat, hispanic) %>%
  summarise(events = n(), .groups = "drop")

