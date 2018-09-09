## packages
install.packages("dplyr")
library(dplyr)

################### Clean data ###################

## data comes from US Dept of Transportation Bureau of Transportation Statistics
## Database Directory = https://www.transtats.bts.gov/DataIndex.asp
## Airline On-Time Performance Data = https://www.transtats.bts.gov/Tables.asp?DB_ID=120&DB_Name=Airline%20On-Time%20Performance%20Data&DB_Short_Name=On-Time
## Download = https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236

## read all files

flight01<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201701_flightdata.csv", na.strings = "NULL" )
str(flight01)
flight02<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201702_flightdata.csv", na.strings = "NULL" )
flight03<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201703_flightdata.csv", na.strings = "NULL" )
flight04<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201704_flightdata.csv", na.strings = "NULL" )
flight05<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201705_flightdata.csv", na.strings = "NULL" )
flight06<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201706_flightdata.csv", na.strings = "NULL" )
flight07<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201707_flightdata.csv", na.strings = "NULL" )
flight08<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201708_flightdata.csv", na.strings = "NULL" )
flight09<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201709_flightdata.csv", na.strings = "NULL" )
flight10<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201710_flightdata.csv", na.strings = "NULL" )
flight11<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201711_flightdata.csv", na.strings = "NULL" )
flight12<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\201712_flightdata.csv", na.strings = "NULL" )

flight2017 <- rbind(flight01, flight02)
flight2017 <- rbind(flight2017, flight03)
flight2017 <- rbind(flight2017, flight04)
flight2017 <- rbind(flight2017, flight05)
flight2017 <- rbind(flight2017, flight06)
flight2017 <- rbind(flight2017, flight07)
flight2017 <- rbind(flight2017, flight08)
flight2017 <- rbind(flight2017, flight09)
flight2017 <- rbind(flight2017, flight10)
flight2017 <- rbind(flight2017, flight11)
flight2017 <- rbind(flight2017, flight12)
str(flight2017)

total1 <- nrow(flight01) +
        nrow(flight02) +
        nrow(flight03) +
        nrow(flight04) +
        nrow(flight05) +
        nrow(flight06) +
        nrow(flight07) +
        nrow(flight08) +
        nrow(flight09) +
        nrow(flight10) +
        nrow(flight11) +
        nrow(flight12) 
total2 <- nrow(flight2017)
total1
total2

flight2017_abridge <- select(flight2017, YEAR, MONTH, DAY_OF_MONTH, ORIGIN_STATE_ABR, CANCELLED, CANCELLATION_CODE)
str(flight2017_abridge)
unique(flight2017_abridge$ORIGIN_STATE_ABR)
length(unique(flight2017_abridge$ORIGIN_STATE_ABR))
# TT, VI, and PR are territories not states
# DE is only state not in data set

states<-read.csv(file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\FourRegions.csv", na.strings = "NULL" )
str(states)

flight2017_merge <- merge(flight2017_abridge, states, by.x = "ORIGIN_STATE_ABR", by.y = "State", all = FALSE)
head(flight2017_merge$Region)
total1 <- nrow(filter(flight2017_merge, ORIGIN_STATE_ABR != "TT" & ORIGIN_STATE_ABR != "VI" & ORIGIN_STATE_ABR != "PR"))
total2 <- nrow(flight2017_merge)
total1
total2

sum(is.null(flight2017_merge$YEAR))
sum(is.null(flight2017_merge$MONTH))
sum(is.null(flight2017_merge$DAY_OF_MONTH))
sum(is.null(flight2017_merge$Region))
sum(is.null(flight2017_merge$CANCELLED))

flight2017_merge$COUNT <- 1
# Per documentation cancel codes are A=Carrier, B=Weather, C=National Air System, D=Security
flight2017_merge$WEATHER_CANCELLED <- ifelse(flight2017_merge$CANCELLED == 1 & flight2017_merge$CANCELLATION_CODE == "B",
                                             1, 0)
flight2017_merge$CARRIER_CANCELLED <- ifelse(flight2017_merge$CANCELLED == 1 & flight2017_merge$CANCELLATION_CODE == "A",
                                             1, 0)
flight2017_merge$NATAIRSYS_CANCELLED <- ifelse(flight2017_merge$CANCELLED == 1 & flight2017_merge$CANCELLATION_CODE == "C",
                                             1, 0)
flight2017_merge$SECURITY_CANCELLED <- ifelse(flight2017_merge$CANCELLED == 1 & flight2017_merge$CANCELLATION_CODE == "D",
                                             1, 0)

flight2017_total <- flight2017_merge %>% 
                    group_by(YEAR, MONTH, DAY_OF_MONTH, Region) %>% 
                    summarise(NumFlights = sum(COUNT), 
                              NumCancels = sum(CANCELLED), 
                              NumWeatherCancels = sum(WEATHER_CANCELLED),
                              NumCarrierCancels = sum(CARRIER_CANCELLED),
                              NumNatAirSys = sum(NATAIRSYS_CANCELLED),
                              NumSecurity = sum(SECURITY_CANCELLED))
flight2017_total
str(flight2017_total)

write.csv(flight2017_total, file = "C:\\Users\\Caroline\\Documents\\cfpDataScience\\FlightCancels\\AggregatedFlightData2017.csv")






