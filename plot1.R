library(lubridate)
library(dplyr)

## Read the data

data <- read.table("household_power_consumption.txt", sep = ";", 
                    header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

## Merge the Date and Time variables into one variable of type Date-Time, and filter
## just the two days we're interested in

data <- data %>%
    mutate(datetime = dmy_hms(paste(Date, Time))) %>%  
    select(-Date, -Time) %>% 
    filter(datetime >= ymd("2007-02-01") & datetime < ymd("2007-02-03"))

## Plot the histogram
## Note - the reference plots are 504x504, but in the instructions we are asked
## to plot into a 480x480 PNG file

png("plot1.png", width=480, height=480, bg="transparent")

hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()