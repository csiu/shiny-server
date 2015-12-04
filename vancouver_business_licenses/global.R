suppressPackageStartupMessages(library(dplyr))
library(readr)
library(ggplot2)
library(viridis)

dat <- read_csv("data/business_licences.csv")
dat <- dat %>%
  #filter(grepl("vancouver", City, ignore.case = TRUE)) %>%
  mutate(
    LicenceRevisionNumber = as.factor(LicenceRevisionNumber),
    Status = as.factor(Status),
    BusinessType = as.factor(BusinessType),
    BusinessSubType = as.factor(BusinessSubType),
    UnitType = as.factor(UnitType),
    City = toupper(City),
    City = as.factor(City),
    Province = toupper(Province),
    Province = as.factor(Province),
    Country = as.factor(Country),
    LocalArea = as.factor(LocalArea),
    NumberOfEmployees = as.double(NumberOfEmployees)
  )
