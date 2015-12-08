library(ggplot2)
library(plyr)
library(dplyr)
#library(cowplot)

bcl <- read.csv("data/bcl-data.csv", stringsAsFactors = FALSE) %>%
  tbl_df()
