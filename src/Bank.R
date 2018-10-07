# prepare the R environment
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  dplyr,         # Data munging functions
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
# Load the data
bm <-"C:\\Users\\Mirela\\RStudioProjects\\Marketing\\datasets\\bank-marketing.csv"

if(!file.exists(bm)){tryCatch(bm)}

if(file.exists(bm)) bm_original <- read.csv(bm, header = TRUE, stringsAsFactors = FALSE, sep = ";")

head(bm_original)

# eliminate any duplicates that may exist in the dataset

bank <- bm_original%>%
  distinct(.keep_all = TRUE,education,balance,age)


# generate an id column for future use (joins etc)
bank$bank_id = seq.int(nrow(bank))

head(bank)
summary(bank)


bank %>%
  ggplot(mapping = aes(education)) +
  geom_bar(aes(fill=marital), width=1, color="black") +
  theme(legend.position = "bottom", legend.direction = "vertical") + ggtitle("Education vs marital statut")

bank %>%
  dplyr::group_by(age = age) %>%
  dplyr::summarize(
    totalcreditors = n(),
    totalbalances = sum(balance),
    balancespercreditors = totalbalances / totalcreditors
  ) %>%
  ggplot(mapping = aes(x = age, y = balancespercreditors)) +
  geom_point() +
  geom_smooth(method = "loess") + ggtitle("Balances per creditors,vs age")

# what values is our dataset missing?

ggplot_missing <- function(x){
  
  x %>%
    is.na %>%
    melt %>%
    ggplot(mapping = aes(x = Var2,
                         y = Var1)) +
    geom_raster(aes(fill = value)) +
    scale_fill_grey(name = "",
                    labels = c("Present","Missing")) +
    theme(axis.text.x  = element_text(angle=45, vjust=0.5)) +
    labs(x = "Variables in Dataset",
         y = "Rows / observations")
}

ggplot_missing(bank)

summary(bank$balance)

# creditors education type: Tertiary, Primary, Secondary,Unknown
bank$tertiary <- FALSE
bank$tertiary[bank$education == "tertiary"] <- TRUE

bank$primary <- FALSE
bank$primary[bank$education %like% "primary"] <- TRUE

bank$secondary <- FALSE
bank$secondary[bank$education %like% "secondary"] <- TRUE

bank$unknown <- FALSE
bank$unknown[bank$education %like% "unknown"] <- TRUE

head(bank)

# not use unknown education creditors 

bank <- bank %>% dplyr::filter(unknown == FALSE)

bkmk_perf <- bank %>%
dplyr::mutate(
bal = (balance > 1000),
dtion = (duration < 150),
edumar = (education == "tertiary" & marital == "married"),
age = age,
job = job,
default = default,
housing = housing,
loan = loan,
contact = contact,
day = day,
month = month,
pdays = pdays,
previous = previous,
poutcome = poutcome,
y = y,
bank_id = bank_id,
tertiary = tertiary,
primary = primary,
secondary = secondary,
unknown = unknown) %>%
dplyr::select (bal, dtion, edumar, age, job, default, housing, loan, contact, day, month, pdays, previous, poutcome,y,bank_id,tertiary,primary,secondary,unknown)
head(bkmk_perf)

formula_balpercentage <- function(totalcustomers, balance) {
  return ((balance) / totalcustomers)
}

plot_balpercentage <- function(bkmk_perf, mincustomers) {
  bkmk_perf %>%
    group_by(job) %>%
    summarize(
      totalcustomers = n(),
      balance = length(bal[bal==TRUE]),
      balpercentage = formula_balpercentage(totalcustomers, balance)
    ) %>%
    filter(totalcustomers >= mincustomers ) %>%
    ggplot(mapping = aes(x = balpercentage, y = totalcustomers)) +
    geom_point(size = 1.5) + 
    geom_text(aes(label=job), hjust=-.2 , vjust=-.2, size=3) +
    geom_vline(xintercept = .5, linetype = 2, color = "red") +
    ggtitle("Balance Percentage vs Customers") +
    expand_limits(x = c(0,1))
} 

plot_balpercentage(bkmk_perf, 120)

# transform old job names into new ones( with CL).
jobNodeMappings <- matrix(c(
  "management","Management",
  "technician","Technician",
  "entrepreneur","Entrepreneur",
  "blue-collar","Blue-collar",
  "unknown","Unknown",
  "services","Services",
  "retired","Retired"
), ncol=2, byrow = TRUE)

for (i in 1:nrow(jobNodeMappings)) {
  bkmk_perf$job[bkmk_perf$job == jobNodeMappings[i,1]] <- jobNodeMappings[i,2]
  
  bank$job[bank$job == jobNodeMappings[i,1]] <- jobNodeMappings[i,2]
  
}

head(bkmk_perf)

# what is the occurence frequency for martital statut?

maritalfreq <- bank %>%
  group_by(marital,job) %>%
  summarise(
    n = n(),
    freq = n / nrow(bank)
  ) %>%
  ungroup() %>%
  mutate(
    maritaltext = paste(marital,"vs",job)
  ) %>%
  arrange(desc(freq)) 

head(maritalfreq, 15)

# distribution of balance per customer
balancefreq <- bank %>%
  group_by(bal= balance) %>%
  summarise(
    n = n(),
    freq = n / nrow(bank)
  ) %>%
  ungroup() %>%
  arrange(desc(freq)) 

head(balancefreq, 25)

balancefreq %>%
  filter(freq >= 0.001) %>%
  ggplot(mapping = aes(x = bal, y = freq)) + geom_bar(stat = "identity") + ggtitle("Balance  per customer distribution")

# distribution of customer age
agefreq <- bank %>%
  group_by(ctage = age) %>%
  summarise(
    n = n(),
    freq = n / nrow(bank)
  ) %>%
  ungroup() %>%
  arrange(ctage) 

head(agefreq %>% filter(abs(ctage)<=35), 15)

agefreq %>%
  filter(abs(ctage)<=35) %>%
  ggplot(mapping = aes(x = ctage, y = freq)) + geom_bar(stat = "identity") + ggtitle("Customer age distribution")

# how many outliers do we have?
out <- bank %>% dplyr::filter(abs(age) > 60)
head(out)
paste(nrow(out), "outliers, or", (nrow(out)/nrow(bank)*100), "% of total.")

# get rid of all the outliers by selecting the age to [20, 60]
bkmk_perf$age[bkmk_perf$age < 20] <- 20
bkmk_perf$age[bkmk_perf$age > 60] <- 60

              