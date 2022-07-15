# loading libraries -------------------------------------------------------

#install.packages(c('readr','here','dplyr','janitor')) #to install the packages

library(readr) # To read our .csv data
library(here) # To know the project path
library(dplyr) # to manipulate data
library(janitor) #To make all the columns names snake_case

# reading data ------------------------------------------------------------
#NetflixOriginals


movie_df <- read_csv( here("data","NetflixOriginals.csv") )
movie_df <- clean_names(movie_df)

# data manipulation -------------------------------------------------------
## row operations ##

#arrange
movie_df |> 
  arrange(desc(runtime), imdb_score)

#filter

movie_df |>
  filter(imdb_score > 7)

#beauty of pipe 
movie_df |> 
  arrange(runtime) |>
  filter(imdb_score > 7) 

movie_df |> 
  filter(imdb_score > 7,runtime < 60)

#slice
#first 10 rows
movie_df |> 
  slice(1:10)

#all rows except first 10 rows
movie_df |> 
  slice(-(1:10))

#top 10 imdb score movies
movie_df |> 
  slice_max(order_by = imdb_score, n = 10)

#10% of data shortest moves
movie_df |> 
  slice_min(order_by = runtime,prop = 0.10)

#random sample of 25% of the data
movie_df |> 
  slice_sample(prop = 0.25)


## column operations ##

#select


movie_df |> 
  select(runtime, imdb_score)

# last_col() is part of tidyselect. Other examples are:
#           (eveything(),starts_with(),contains(),ect..)

movie_df |> 
  select(last_col())


#we can go over case_when again in the next class
movie_df |> 
  mutate(language = case_when(
    language == "English" ~ "1",
    TRUE ~ language )
  )

#rename , rename_with
movie_df |> 
  rename(IMDB_Score = imdb_score,
         GENRE = genre)

movie_df |> 
  rename_with(.fn = toupper,
              .cols = where(is.numeric))
  
#mutate 
movie_df |> 
  mutate(watched = "Yes",
         runtime = runtime * 2,
         title = NULL)

new_df <- movie_df |>
  mutate(watched = case_when(imdb_score < 3 ~ "No",
                             TRUE ~ "Yes"))


#relocate , where()
new_df |> 
  relocate(watched,
           .after = imdb_score)

new_df |> 
  relocate(where(is.numeric),
           .before = where(is.character))


# group of row ------------------------------------------------------------
#summarise & group_by

new_df |> 
  summarise(movie_avg = mean(runtime))

new_df |> 
  group_by(language) |> 
  summarise(movie_avg = mean(runtime),
            movie_count = n()) |> 
  arrange(desc(movie_count))


#count / add_count

new_df |> 
  count(language,sort = T)

new_df |> 
  add_count(language) |> 
  View()

new_df |> 
  add_count(genre) |> 
  View()

#distinct

new_df |> 
  distinct(genre,runtime, .keep_all = T)











