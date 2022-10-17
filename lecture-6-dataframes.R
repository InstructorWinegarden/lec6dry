# Data Frames
#----------------------------------------------------------------------------#
# Lecture Lecture 06
# Updated: January, 15, 2022 (David Hendry)
# Re-purposed: Oct, 17, 2022 (Thomas Winegarden) (Thanks prof Hendry!)
#----------------------------------------------------------------------------#
# This script contains code that is used in class demonstrations. Please 
# follow along during class and explore it after class.  Use your eye to parse
# each statement and use your mind to simulate R. 
#
# Your goal is to understand each of these basic building blocks for writing R 
# programs. If something is not clear: 
#
#     1. Change the R Code, re-run the code, and explore it
#     2. Ask someone
#     3. Go to the textbook or other documentation
#     4. (Try a google search)
#
# You will need each of these building blocks for completing Assignment 1
# and all subsequent assignments.
#----------------------------------------------------------------------------#

# Review of vectors, lists, and data frames 

# Recall: Question on rounding! 
# Note that the behavior of round() is a little odd. In short, when rounding
# at 5, round() goes to the nearest even digit, which might be 
# confusing. 
# See ?round(): "Note that for rounding off a 5, ... "go to the even digit" 
round(.5 + -2:4) # IEEE / IEC rounding: -2  0  0  2  2  4  4
paste0 ("round(1.5) -->   2.0: Check: ", (TRUE == (round(1.5) == 2.0)))   
paste0 ("round(2.5) -->   2.0: Check: ", (TRUE == (round(2.5) == 2.0)))
paste0 ("round(0.5) -->   0.0: Check: ", (TRUE == (round(0.5) == 0.0)))
paste0 ("round(-1.5) --> -2.0: Check: ", (TRUE == (round(-1.5) == -2.0)))
paste0 ("round(1.5) --> 2.0: Check: ", (TRUE == (round(1.6) == 2.0)))
paste0 ("round(2.6) --> 3.0: Check: ", (TRUE == (round(2.6) == 3.0)))

# You might want to investigate these two functions which are related to 
# rounding
#?ceiling()
#?floor()

# Recall: Lists. Lists allow us to model complex structures.  
# These temperature readings might come from public school in 
# Washington State: 

temp_reading_rec1 <- list(
  location = "Bothell, WA", 
  readings_date1 = "2022-01-13",
  readings_date2 = "2022-01-15",
  validated = FALSE,
  responsible = list (reader = "Riley Douglas", 
                      checker = "Fred Money"),
  readings = c(44.1, 57.3, 46.5, 51.1, 47.9, 60.5, NA, 44.1, 38.0, 36.4, 43.5)
)

temp_reading_rec2 <- list(
  location = "Seattle, WA", 
  readings_date1 = "2022-01-13",
  readings_date2 = "2022-01-15",
  validated = FALSE,
  responsible = list (reader = "Alex Smilely", 
                      checker = NA),
  readings = c(46.3, 60.2, 45.1, NA, 47.9, 62, NA, 37.7, 38.8, 30.9)
)

View(temp_reading_rec2)

# A function for computing the average of the temperature readings
avg_readings <- function (temp_rec) {
  avg <- mean(temp_rec$readings, na.rm=TRUE)
  return(avg)
}

# A function for finding the names of the people who are responsible 
# for the readings
responsible_person <- function (temp_rec, role="reader") {
  t <- temp_rec$responsible[[role]]
  return (t)
}

# dollar sign notation 
t <-temp_reading_rec2$location
is.list(t)

# double-bracket notation 
t <- temp_reading_rec2[["location"]]
is.list(t)

# This will fail because t is not a list! (It is vector of length 1)
t$location
length(t)

# single-bracket notation 
t <- temp_reading_rec2["location"]
is.list(t)

# This works because t is a list! 
t$location 

# Using the notation in functions
avg_readings(temp_reading_rec1)
responsible_person(temp_reading_rec1)
responsible_person(temp_reading_rec1, "checker")

# Creating a list of lists
temp_recs <- list()
temp_recs <- append(temp_recs, list(rec=temp_reading_rec1))
temp_recs<- append(temp_recs, list(rec=temp_reading_rec2))
View(temp_recs)

# Using the lapply() function 
t_list <- lapply(temp_recs, avg_readings)
print(t_list)
View(t_list)

# Use double bracket notation and indexes
t_list[[1]]
t_list[[2]]

# Using sapply() function 
t_vector <- sapply(temp_recs, avg_readings)
print(t_vector)
View(t_vector)

View(t_vector)
print(t_vector)
t_vector[1]
t_vector[2]

# Data Frames 
# Four vectors are initialized 
temp_dates <- c("2021-12-01", "2021-12-02", "2021-12-03", "2021-12-04")
temp_daily_min <- c(46, 33, 39.5, NA)
temp_daily_max <- c(60, 36, NA, 48)
temp_validated <- c(TRUE,T, TRUE, F)

# Initialize a data frame from four vectors
temp_info_df <- data.frame(date = temp_dates, 
                           min = temp_daily_min, 
                           max = temp_daily_max,
                           validated = temp_validated,
                           stringsAsFactors=FALSE)
View(temp_info_df)


# Initialize a data fram  a URL to a CSV file 
filename <- "https://raw.githubusercontent.com/info-201a-wi22/misc/main/lecture-5-temps-header.csv"
temps_df <- read.csv(filename, header=TRUE, stringsAsFactors=FALSE)
View(temps_df)

# Initialize a data from a URL  - note header is FALSE 
filename <- "https://raw.githubusercontent.com/info-201a-wi22/misc/main/lecture-5-temps-no-header.csv"
temps_df <- read.csv(filename, header=FALSE, stringsAsFactors=FALSE)
View(temps_df)

# some functions you can run on a dataframe
nrow(temps_df)
ncol(temps_df)
dim(temps_df)
colnames(temps_df)
rownames(temps_df)

## Extract the vectors from a data frame 
t<-temps_df$Max.Temp
print(t)

## 2D selectors
## Access data by index into Rows and Columns. [Row,Column] //  [Row is first, Column is section]
temps_df[,1]
temps_df[1,]
temps_df[1,1]

# Access data by name
t1 <- temps_df[,"Max.Temp"]
t1
t2 <- temps_df[,2]
t2


# Load file from directory on your machine
getwd() 
setwd("/Users/dhendry/Documents/_Code/xx")
filename <- "lecture-5-temps-no-header.csv"
temps_df <- read.csv(filename, header=TRUE, stringsAsFactors=FALSE)
View(temps_df)






