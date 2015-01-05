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

## Plot to a png file

png("plot4.png", width=480, height=480, bg="transparent")

par(mfcol = c(2,2))

## The Global active power plot (top left)
with (data, plot(datetime, Global_active_power, type = "l", xlab="", ylab="Global Active Power"))
    
## The Sub metering plot (bottom left)
with (data, { 
        plot(datetime, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
        points(datetime, Sub_metering_2, type = "l", col = "red")
        points(datetime, Sub_metering_3, type = "l", col = "blue")
        })

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lwd = 1, bty = "n")

## The voltage and the global reactive power plots on the right
with (data, { 
         plot(datetime, Voltage, type = "l")
         plot(datetime, Global_reactive_power, type = "l")
        })

dev.off()