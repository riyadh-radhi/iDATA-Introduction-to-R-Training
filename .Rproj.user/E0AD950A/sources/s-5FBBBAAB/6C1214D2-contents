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
library(DT)
library(reactable)
## reading data ----
df <- read_csv("ted_talks_data.csv")

## data manipulation ----
### first_plot data cleaning ----
df |>
  mutate(date = my(date)) |>
  mutate(talk_year = year(date)) |>
  group_by(talk_year) |>
  summarise(total_views = sum(views, na.rm = T)) |>
  ungroup() |>
  mutate(covid_year = case_when(talk_year >= 2019 ~ "Yes",
                                TRUE ~ "No")) -> plt_df

### second_plot data cleaning ----
df |>
  mutate(date = my(date)) |>
  mutate(
    talk_year = year(date),
    talk_month = month(date),
    link_action = paste0('window.open("',
                         link,
                         '")')
  ) -> plt_two_df

# UI ----
ui <- dashboardPage(
  ## Header ----
  header = dashboardHeader(title = "iDATA"),
  ## Sidebar ----
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem(
        text = "Aggregated Analysis",
        tabName = "aggregated_analysis",
        icon = icon(name = "line-chart")
        ),
      menuItem(
        text = "Individual Ted Talks",
        tabName = "individual_talks"
        ),
      menuItem(
        text = "Raw Data",
        tabName = "raw_data"
      )
      
      )
    ),
  ## Body ----
  body = dashboardBody(
    tabItems(
      ### aggregated_analysis ----
      tabItem(
        tabName = "aggregated_analysis",
        fluidRow(
          box(
            girafeOutput(outputId = "first_plot"), width = 12
            )
          )
        ),
      ### indiviudal_talks ----
      tabItem(
        tabName = "individual_talks",
        fluidRow(
          box(
            selectInput(
              inputId = "talk_year_input",
              label = "Select Talk Year",
              choices = plt_df$talk_year,
              selected = 2020
              ),width = 3
            ),
          box(girafeOutput(outputId = "second_plot"), width = 12)
          )
        ),
      ### raw_data ----
      tabItem(
        tabName = "raw_data",
        fluidRow(
          box(
            reactableOutput(outputId = "raw_data_output")
          )
        )
      )
      )
    )
  )
  
  # Server ----
  server <- function(input, output) {
    ## first_plot ----
    output$first_plot <- renderGirafe({
      ggplot(data = plt_df, aes(x = talk_year, y = total_views)) +
        geom_point_interactive(
          mapping = aes(
            color = covid_year,
            tooltip = talk_year,
            data_id = talk_year
          ),
          size = 3
        ) +
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
        theme(
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          
          legend.title = element_text(size = 11, color = "#3d3d3d"),
          legend.text = element_text(size = 10, color = "#3d3d3d"),
          plot.title = element_text(hjust = 0.5, color = "#3d3d3d"),
          axis.title = element_text(color = "#3d3d3d"),
          axis.text.x = element_blank()
        ) -> static_plot
      
      girafe(ggobj = static_plot, width_svg = 12)
      
    })
    
    ## second_plot ----
    filtered_data <- reactive({
      plt_two_df |>
        filter(talk_year %in% input$talk_year_input)
    })
    
    output$second_plot <-  renderGirafe({
      ggplot(data = filtered_data(), aes(x = talk_month, y = views)) +
        geom_point_interactive(
          aes(tooltip = title, onclick = link_action),
          size = 3,
          color = "#2c5b78",
          alpha = 0.4
        ) +
        theme_minimal() +
        labs(title = "Ted Talks Views by Months",
             x = "Months",
             y = "Talk Views") +
        scale_x_continuous(breaks = c(1:12)) +
        scale_y_continuous(breaks = pretty_breaks(6),
                           labels = label_number(scale_cut = cut_short_scale())) +
        theme(
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          plot.title = element_text(hjust = 0.5, color = "#3d3d3d"),
          axis.title = element_text(color = "#3d3d3d")
        ) -> plot_two
      
      girafe(ggobj = plot_two, width_svg = 12)
      
    })
    
    ## raw_data_output ----
    output$raw_data_output <- renderReactable({
      reactable(
        df, filterable = TRUE
      )
    })
    
  }
  
  
  # Run the application
  shinyApp(ui = ui, server = server)
  