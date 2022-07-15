
###### Operators ########

# R Arithmetic Operators --------------------------------------------------
# + - * / %% 

1 + 1
5 - 5
0 - 5
2 * 10 
2 / 10
11 %% 2

# R Relational Operators --------------------------------------------------
# < > <= >= ==  !=

2 > 1
1 < 2
2 == 2
2 == 0
2 != 0

# R Logical Operators -----------------------------------------------------
# ! & |

TRUE & TRUE
TRUE & FALSE
FALSE  & FALSE

TRUE | TRUE
TRUE | FALSE
FALSE  | FALSE

!TRUE

# R Assignment Operators --------------------------------------------------
# <- 

x <- 1
y <- 2

x + y

###### Data Types ########

# Numeric -----------------------------------------------------------------
#class() function
1
2
class(2)
# Character ---------------------------------------------------------------
x<- "iDATA"
class(x)

# Logical -----------------------------------------------------------------
#TRUE , FALSE, NA
class(TRUE)
FALSE
NA
###### Data Structure ########


# vectors -----------------------------------------------------------------
# c()
my_vector <- c(1,2,3)
my_string_vector <- c("Adham", "knows", "concat")
c(TRUE, FALSE)
c(1, "iDATA")

my_vector + 1

# dataframes --------------------------------------------------------------

my_first_df <- data.frame(num_vector = c(1,2,3),
           character_vector = c("Adham", "knows", "concat"),
           logical_vector = c(TRUE, FALSE, T))



# list --------------------------------------------------------------------

#list()
my_first_list <- list(myDataFrame = my_first_df,
     myVector = c(1,2))

###### Basic Functions ########

# : seq() rep() length() mean() abs() as.numeric() min() max() is.numeric()

odd_num_seq <- seq(1,10,by = 2)
five_vector <- rep(5,10)

length(five_vector)

mean(odd_num_seq)
sum(odd_num_seq) / length(odd_num_seq)
abs(-10)

