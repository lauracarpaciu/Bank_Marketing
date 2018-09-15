# prepare the R environment
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  dplyr,            # Data munging functions
  zoo,              # Feature engineering rolling aggregates
  data.table,       # Feature engineering
  ggplot2,          # Graphics
  scales,           # Time formatted axis
  readr,            # Reading input files
  stringr,          # String functions
  reshape2,         # restructure and aggregate data 
  randomForest,     # Random forests
  corrplot,         # correlation plots
  Metrics,          # Eval metrics for ML
  vcd               # Visualizing discrete distributions
)

# set options for plots
options(repr.plot.width=6, repr.plot.height=6)

# Load the matches data

bankFile <- "C:\\Users\\Mirela\\RStudioProjects\\Marketing\\datasets\\bank-marketing.csv"

if(!file.exists(bankFile)){tryCatch(bankFile)}

if(file.exists(bankFile))bank_marketing_original <- read.csv(bankFile)

head(bank_marketing_original)

