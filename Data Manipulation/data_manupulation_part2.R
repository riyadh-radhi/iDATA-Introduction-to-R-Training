# loading libraries -------------------------------------------------------

library(here)
library(readr)
library(dplyr)
library(lubridate)
library(tidyr)

# reading data "NetflixOriginals" -----------------------------------------------

df <- read.csv(here("data", "NetflixOriginals.csv"))


################## lubridate #########################

#parsing dates using lubridate functions (changing the class
#of our variable into date class)

#ymd , mdy, dmy

df <- df |> 
  mutate(Premiere = mdy(Premiere))

#Extracting month, year, day columns from our date variable
#month, year, day

date_df <- df |> 
  select(Premiere) |> 
  mutate(prem_day = day(Premiere),
         prem_month = month(Premiere),
         prem_year = year(Premiere))


#Finding the name of day of the week and day count from our date variable
#wday, yday

date_df |> 
  mutate(week_day = wday(Premiere,label = T),
         count_day = yday(Premiere))

#today, now
today() # Today date
now() # today date with time
now(tzone = "America/Argentina/San_Luis") #today date with time for different time zones
#OlsonNames, to see the list of timezones

#One option to construct dates is to use:
#make_date()

ydm("2000,20,05")
my_date <- make_date(year = 2000,month = 11,day = 12)




#rounding with dates:
#round_date, floor_date, ceiling_date

round_date(my_date,unit = "year")

date_df |> 
  mutate(floored_date = floor_date(Premiere,unit = "month"))

#### arithmetic  with dates ######

#period

my_date + months(3) + days(3)

#interval()
#intervals has start and end dates 
covid_19_date <- make_date(year = 2019,month = 11,day = 23)

#time_length
#find the duration of your interval

interval(start = covid_19_date, end = now()) |> 
time_length(unit = "month")


################## tidyr #########################

#unite
df |>
  unite(col = "Title_genre", c("Title", "Genre"),remove = F)

#separate

lnaguage_df <- df |>
  select(Title, Language) |> 
  separate(col = Language,
           into = c("lan_1","lan_2","lan_3"),
           sep = "/")


#pivot_longer

long_language_df <- lnaguage_df |> 
  pivot_longer(cols = contains("lan"),
               names_to = "Languages_count",
               values_to = "Languages",)

#pivot_wider

wide_language_df <- long_language_df |> 
  pivot_wider(names_from = Languages_count,
              values_from = Languages)



