###### Function 1 #########
double_the_number <- function(number){
  return(number * 2)
}

#double_the_number(number = 10)

###### Function 2 #########


what_is_the_age <- function(user_year, user_month,
                            user_day,user_unit = "year"){
  
  user_info <- make_date(year = user_year,
            month = user_month,
            day = user_day)
  return(interval(start = user_info,end = today()) |> 
    time_length(unit = user_unit))
  
}

# what_is_the_age(user_year = 1999,user_month = 11,
#                 user_day = 3,user_unit = "month")

#what_is_the_age(1999,11,3,"month")


###### Function 3 #########

#df <- read_csv(here("data", "ted_talks_data.csv"))

make_year <- function(variable){
  df |> 
    mutate(new_date = my(.data[[variable]])) |>
    mutate(year = year(new_date)) -> new_data
  
  return(new_data)
}

#make_year(variable = "date") |> View()

###### Function 4 #########

cleaning_plotting <- function(data, variable){
  data |> 
    mutate(new_column = case_when(.data[[variable]] %in% 1 ~ "Strongly agree",
                               .data[[variable]] %in% 2 ~ "Agree",
                               .data[[variable]] %in% 3 ~ "Disagree",
                               .data[[variable]] %in% 4 ~ "Strongly disagree",
                               .data[[variable]] %in% 98 ~ "Don’t know",
                               .data[[variable]] %in% 99 ~ "Refused to answer")) |> 
             
  count(new_column) |> 
    mutate(percentage = round((n / sum(n)) * 100, 2)) |> 
    filter(!new_column %in% c("Don’t know","Refused to answer")) |> 
    ggplot(aes(new_column, percentage)) +
    geom_col(fill = "#2c5b78", alpha = 0.8) +
    labs(x = "", 
         y = "% of Responders", 
         title = variable) +
    theme_minimal() +
    theme(panel.grid = element_blank()) +
    geom_text(aes(label = paste0(percentage, " %"),
                  y = percentage + 2))
}


