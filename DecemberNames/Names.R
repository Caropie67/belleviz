# data downloaded from https://ssdmf.info Dec 2018
# insightful blog "Are More Junes Born in June?" http://www.slate.com/articles/arts/culturebox/2014/07/baby_names_how_the_calendar_affects_the_naming_process.html

library(dplyr)

# get number of rows in file
# reads 30000 at a time so takes just a minute or so
testcon <- file("C:\\Users\\Caroline\\Downloads\\ssdm3\\ssdm3",open="r")
readsizeof <- 30000
nooflines <- 0
( while((linesread <- length(readLines(testcon,readsizeof))) > 0 )
    nooflines <- nooflines+linesread )
close(testcon)
nooflines
#28607398

# create empty dataset of 500,000 records
# will hold only a fraction of the records
df3 <- data.frame(matrix(ncol = 2, nrow = 500000))
x <- c("firstname", "date")
colnames(df3) <- x

# process a line then skip 50
con <- file("C:\\Users\\Caroline\\Downloads\\ssdm3\\ssdm3",open="r")
for (i in 1:500000) 
{
    oneLine <- readLines(con, n = 1, ok=TRUE)
    myLine <- unlist((strsplit(oneLine, ",")))
    name <- trimws(substr(myLine, 34, 49))
    date <- trimws(substr(myLine, 74, 81))
    df3$firstname[i] <- name
    df3$date[i] <- date
    readLines(con, n = 50, ok=TRUE)
    if (i %% 1000 == 0) { print(i) }
} 
close(con)
# got some warnings - looks like I overshot the size of df3 but that's OK

nrow(df3)
head(df3, 20)
tail(df3, 20)
str(df3)

# preserve df3 in case mess up
data <- df3

# extract month, day, and year first checking for null values
sum(is.null(data$firstname))
# 0
sum(is.null(data$date))
# 0
data$month <- substr(data$date, 1, 2)
data$day <- substr(data$date, 3, 4)
data$year <- substr(data$date, 5, 8)
head(data)

# check for invalid months
sum(data$month < "01" | data$month > "12")
# 606
data <- filter(data, data$month >= "01" & data$month <= "12")
nrow(data)

# check for invalid day
sum(data$day < "01" | data$day > "31")
# 251
data <- filter(data, data$day >= "01" & data$day <= "31")
nrow(data)

# check for invalid year
sum(data$year < "1700" | data$year > "2018")
# 82
data <- filter(data, data$year >= "1700" & data$year <= "2018")
nrow(data)

# check for invalid month/day combinations
sum(data$month == "02" & data$day > "29")
# 1
data <- filter(data, !(data$month == "02" & data$day > "29"))
nrow(data)
sum((data$month == "04" | data$month == "06" | data$month == "09" | data$month == "11") & data$day > "30")
# 8
data <- filter(data, !((data$month == "04" | data$month == "06" | data$month == "09" | data$month == "11") & data$day > "30"))
nrow(data)

# check for empty name
sum(data$firstname == "")
# 1
data <- filter(data, firstname != "")
nrow(data)

# save as csv
write.csv(data, file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\Names2\\NamesWithBirthDates3.csv")

# count occurrence of each name
aggdata <-  count(data, firstname)
nrow(aggdata)
# 27877 names
head(aggdata)
tail(aggdata)

# count occurrence of each name in Dec
data.dec <- filter(data, month == '12')
nrow(data.dec)
head(data.dec)
aggdata.dec <- count(data.dec, firstname)
nrow(aggdata.dec)
# 5538
head(aggdata.dec)
tail(aggdata.dec)

# merge aggregate data
aggdata.merged <- merge(aggdata, aggdata.dec, by.x = 'firstname', by.y = 'firstname', all = TRUE)
nrow(aggdata.merged)
# 27877 names
head(aggdata.merged)

# cleanup column names
colnames(aggdata.merged) <- c("firstname", "n", "december.n" )
head(aggdata.merged)

# if no december.n, set to 0
head(aggdata.merged)
aggdata.merged$december.n <- ifelse(is.na(aggdata.merged$december.n), 0, aggdata.merged$december.n)
head(aggdata.merged)

# add jan to nov count
aggdata.merged$jan.to.nov.n <- aggdata.merged$n - aggdata.merged$december.n
head(aggdata.merged)

# only include names with dec counts of 10 or more
sum(aggdata.merged$december.n >= 10)
aggdata.merged <- filter(aggdata.merged, december.n >= 10)
nrow(aggdata.merged)
# 623 names

# any zeros from jan to nov?
sum(aggdata.merged$jan.to.nov.n == 0)

# save as csv
write.csv(aggdata.merged, file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\Names2\\NamesWithBirthDates3_Aggregates.csv")






