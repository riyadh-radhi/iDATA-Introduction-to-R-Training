# Global ----

## Load libraries ----
library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(here)
library(ggplot2)
library(scales)
library(lubridate)
library(ggiraph)

## reading data ----
df <- read_csv(here("data", "ted_talks_data.csv"))

## data manipulation ----
df |> 
  mutate(date = my(date)) |> 
  mutate(talk_year = year(date)) |> 
  group_by(talk_year) |> 
  summarise(total_views = sum(views,na.rm = T)) |> 
  ungroup() |> 
  mutate(covid_year = case_when(talk_year >= 2019 ~ "Yes",
                                TRUE ~ "No")) -> plt_df

# UI ----
ui <- dashboardPage(
  ## Header ----
  header = dashboardHeader(title = "iDATA"),
  ## Sidebar ----
  sidebar = dashboardSidebar(disable = TRUE),
  ## Body ----
  body = dashboardBody(
    fluidRow(
      box(
        girafeOutput(outputId = "first_plot"),width = 12
      )
    )
  )
  
)

# Server ----
server <- function(input, output) {
## first_plot ----
  output$first_plot <- renderGirafe({
    
    ggplot(data = plt_df, aes(x = talk_year, y = total_views)) +
      geom_point_interactive(mapping = aes(color = covid_year,
                                           tooltip = talk_year, 
                                           data_id = talk_year), size = 3) +
      theme_minimal() +
      labs(title = "Total Ted Talks Views by Year", 
           x = "Talk Year", 
           y = "Total Views") +
      scale_color_manual(values = c("Yes" = "#869c62",
                                    "No" = "#65a0a8"),
                         name = "COVID19") +
      scale_x_continuous(breaks = pretty_breaks(6)) +
      scale_y_continuous(breaks = pretty_breaks(6),
                         labels = label_number(scale_cut = cut_short_scale())) +
      theme(panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank(),
            
            legend.title = element_text(size = 11,color = "#3d3d3d"),
            legend.text = element_text(size = 10,color = "#3d3d3d"),
            plot.title = element_text(hjust = 0.5, color = "#3d3d3d"),
            axis.title = element_text(color = "#3d3d3d"),
            axis.text.x = element_blank()) -> static_plot
    
    girafe(ggobj = static_plot,width_svg = 12)
    
  })
  

}


# Run the application 
shinyApp(ui = ui, server = server)


























