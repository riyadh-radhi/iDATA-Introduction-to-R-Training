options(scipen = 99)
# loading libraries -------------------------------------------------------

library(here)
library(readr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)
library(ggrepel)
library(patchwork)
# reading data "ted_talks_data" -----------------------------------------------

df <- read.csv(here("data", "ted_talks_data.csv"))


################## data prepration #############

#make column for year
df |> 
  mutate(date = my(date)) |> 
  mutate(talk_year = year(date)) |> 
  select(talk_year, likes) -> modified_df

#create a data containing total likes and views in each year

modified_df |> 
  group_by(talk_year) |> 
  summarise(total_likes = sum(likes,na.rm = T)) -> plot_df

################## ggplot #########################

# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

#################  scatter plot ##########################
##########################################################

#add new column to you data based if the year after covid or before

plot_df |> 
  mutate(COVID_year = case_when(talk_year < 2019 ~ "No",
                                talk_year >= 2019 ~ "Yes")) -> plot_df

#1- make a scatter plot between talk year and total likes
#2- add ready theme
#3- add plot title, axis titles
#5- add the new variable as color to your plot
#6- change the color of your points to #869c62 and #65a0a8
#7- fix the x-axis scale using pretty_breaks
#8- fix the y-axis scale using pretty_breaks & label_number
#9- change the legend title
#10- remove vertical grid lines
#11- adjust text sizes
#12- change text color to "#3d3d3d"
#13- add the year of each point in the plot using ggrepel packages

ggplot(data = plot_df, aes(x = talk_year, y= total_likes)) +
  geom_point(mapping = aes(color = COVID_year, fill = COVID_year), 
             shape = 21, size = 2.5, alpha = 0.4)+
  theme_minimal() +
  labs(title = "Total Ted Talks Likes over the Years", 
       y = "Total Likes", x = "Talk Year") +
  #to change the color and fill of the points
  scale_fill_manual(values = c("#ed6d64", "#879ede")) +
  scale_color_manual(values = c("red", "blue"))+
  #fixing the  y axis
  scale_y_continuous(breaks = pretty_breaks(n = 7),
                     labels = label_number(scale_cut = cut_short_scale()))+
  theme(panel.grid.minor.y = element_blank(), 
        plot.title = element_text(size = 14, colour = "#3d3d3d",
                                  hjust = 0.5), 
        axis.title = element_text(size = 14, colour = "#3d3d3d"),
        axis.text = element_text(size = 13, colour = "#3d3d3d"), 
        legend.text = element_text(size = 13, colour = "#3d3d3d"), 
        legend.title = element_text(size = 14,  colour = "#3d3d3d"),
        axis.text.x = element_blank()) +
  geom_text_repel(mapping = aes(label = talk_year))
  
plo2 <- plot1

plot1 + plo2

#save the plot with width = 13 and height = 6
ggsave(filename = "iDATA_plot.png", path = here(),
       width = 13, height = 6)

####################### bar plot #########################
##########################################################

#1- create a data with the total count of talks over the years
#2- create a bar chart
#3- add ready theme
#4- add plot title, axis titles
#5- remove grid lines, and change title and axis colors to #3d3d3d
#6- make the bar plot on the y-axis
#7- add the number of movies in front of each bar plot
#8- order the bar plot from top to least

#save the plot


