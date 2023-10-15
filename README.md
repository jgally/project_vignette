Project 2
================
Jasmine Gallaway
10-14-2023

## Beginner Friendly Havard Art Museum API Query

So you like art. You like the art that is in the Harvard Art Museum. You
want to know the numbers and data behind the art in the museum. The
Harvard Art Museum API is the resource for you. This vignette is the
resource to make your API data dive easier!

There’s many parts to obtaining the data from an API. Typically a URL
must be made to call the API, the returned data will need to be parsed
into a readable format, and then sort and clean the data to uncover your
perfect dataset. For coding beginners this may seem like a daunting
task; however, this vignette will guide you through the steps- starting
with what packages you need downloaded.

### Necessary Libraries

This whole vignette was accomplished with a few installed packages.
Those packages are:

- `httr` to call the API
- `jsonlite` to make the JSON API output more readable in R  
- `dplyr` to manipulate data
- `tidyverse` to transform and present data
- `ggplot2` to make graphics

## How to Query the Harvard Art API

After reading in those libraries the next step is to code your query! In
my experience, making sure the syntax on the API call is correct can be
a lot when starting out. Good thing that the Harvard Art Museum API is
very beginner friendly! There is plenty of good documentation to explain
the database so figuring out what resources or filters to use isn’t so
difficult. To make the process more simple I have created multiple
functions to go through the call, parsing, and filtering of data from an
API. So after you sign up for an API key on the Harvard Art Museum API
website, feel free to try out these helpful functions.

### Homemade Functions

`composing_URL`

In this function the inputs are “resource”, “filtering”, and “key”. All
three of these inputs must to be entered as a character string with
quotes around the option. `composing_URL` will return one of two base
URL formats to access the API. These base URLs can be made unique with
the multitude of options for the arguments.

``` r
#This function will return the URL to use to access the correct API endpoint
composing_URL <- function(resource, key, filtering = "na"){
  my_URL <- if(filtering != "na"){
    paste0("https://api.harvardartmuseums.org/",resource,"?q=",filtering,"&apikey=",key)}
    else{
    paste0("https://api.harvardartmuseums.org/",resource,"&apikey=",key)
    }
  return(my_URL)
}
```

`more_pages`

In case you need more data for your uses, I created a pagination
function to help ease the process of gathering more information from the
Harvard Art Museum API. This API does have a limit of 10,000 entries per
API key so be wise in how you are grabbing data. The input includes your
base URL, where you want to set your limit at (the default is 1,000 so
you don’t query all in one spot, remember 10,000 is the limit set by the
API and you cannot change that), and how many items you would like to
see on each page.

``` r
#A while loop is a good fit to watch your limits. It only works while a condition is true.
more_pages <- function(my_URL, limit = 1000, items_per_page){
  #Setting up all other variables for this function  
  #Setting this at zero for when you begin to query  
  items_received <- 0  
  
  #This variable is telling R what page we are on  
  on_page <- 1  
  
  #Here is the conditional while loop  
  while (items_received < limit){
    #Creating another with page number in the URL  
    page_URL <- paste0(my_URL, "?page=", on_page)
  }
  
  
}
```

`object_info`

If you’re a little lost in where to start your search I have also made
some other functions to query more specific endpoints of the Harvard Art
Museum API. `object_info` is one of the resources in this API is
“object” which gives more information about the artwork, artist, online
view count, and even what medium was used. The purpose of this function
is to access the object ID, what century it is from, what culture it is
from, and the total online page views. The object ID is included in this
tibble in case you would like to remember a specific object to call for
later on. The only input is your personal API key and the end result
should be a table of object information.

``` r
#Calling the API for object, information  
object_info <- function(key){
  #Providing the base URL  
  base_URL <- "https://api.harvardartmuseums.org/object?apikey="  
  
  #Pasting together the API
  object_URL <- paste0(base_URL, key)  
  
  #Pulling data from the API
  my_data <- httr::GET(object_URL)  

  #Turning data into a table that is readable in R
  readable_table <- fromJSON(rawToChar(my_data$content))  

  #Picking out the objectid, century, culture, and totalpageviews
  selected_table <- select(readable_table$records, objectid, century, culture, totalpageviews)

  #Printing out the table a little nicer as a tibble  
  informational_table <- as_tibble(selected_table)  
  
  #Remove rows with NA  
  informational_table <- na.omit(informational_table)  

  #Returning the informational table }
  print(informational_table)
}
```

`cultured_objects`

This function is to call to the API for more information about the
objects, but only selecting a particular culture of objects to look at.
Some options that the Harvard Art Museum API has is American, Coptic,
Byzantine, and Japanese. The only necessary input is your API key and
the culture name which should be specified in quotations.

``` r
#Calling the API for objects from a specific culture  
cultured_objects <- function(key, culture){
  #Providing the base URL  
  base_URL <- "https://api.harvardartmuseums.org/object?apikey="  
 
  #Pasting together the API
  cult_obj_URL <- paste0(base_URL,key,"&q=culture:",culture)  
  
  #Pulling data from the API
  my_data <- httr::GET(cult_obj_URL)  

  #Turning data into a table that is readable in R
  readable_table <- fromJSON(rawToChar(my_data$content))  

  #Picking out the objectid, century, culture to assure you received the correct information, and totalpageviews
  selected_table <- select(readable_table$records, objectid, century, culture, totalpageviews)

  #Printing out the table a little nicer as a tibble  
  informational_table <- as_tibble(selected_table)  
  
  #Remove rows with NA  
  informational_table <- na.omit(informational_table)  

  #Returning the informational table 
  print(informational_table)  
}
```

`century_objects`

Maybe you’re more of a history buff, and you would like to only learn
about objects from your favorite century. `century_objects` function can
help you out! The input need for this function is your API key and which
century you would like to look at. Century should be in the format of:
“14th century BCE” or “6th millennium BCE”.

``` r
#Calling the API for objects from different centuries  
century_objects <- function(key, century){
  #Providing the base URL  
  base_URL <- "https://api.harvardartmuseums.org/object?apikey="  
  
  #Pasting together the API
  cent_obj_URL <- paste0(base_URL,key,"&q=century:",century)  
  
  #Pulling data from the API
  my_data <- httr::GET(cent_obj_URL)  

  #Turning this into a table that is readable in R
  readable_table <- fromJSON(rawToChar(my_data$content))  

  #Picking out the objectid, century to assure correct information is received, culture, and totalpageviews 
  selected_table <- select(readable_table$records, objectid, century, culture, totalpageviews)

  #Printing out the table a little nicer as a tibble  
  informational_table <- as_tibble(selected_table)  
  
  #Remove rows with NA  
  informational_table <- na.omit(informational_table)

  #Returning the informational table 
  print(informational_table)  
}
```

`find_people`

Are you more of a people person? If you would like to know more about
the people behind the work `find_people` can introduce you to some
information. In this function the person ID (like object ID this can be
used to call information about a specific person later), binary gender,
culture, object count (how many pieces from them), and the date they
began to show the work are returned in a neat little table as a result.

``` r
#Calling the API for people who have had something displayed at the Harvard Art Museum  
find_people <- function(key){
    #Providing the base URL  
  base_URL <- "https://api.harvardartmuseums.org/person?apikey="  
  
  #Pasting together the API
  person_URL <- paste0(base_URL, key)  
  
  #Pulling data from the API
  my_data <- httr::GET(person_URL)  
  
  #Turning this into a table that is readable in R
  readable_table <- fromJSON(rawToChar(my_data$content))  

  #Picking out the personid, displayname, gender, objectcount, and datebegin  
  selected_table <- select(readable_table$records, personid, displayname, gender, objectcount, datebegin)

  #Printing out the table a little nicer as a tibble  
  informational_table <- as_tibble(selected_table)

  #Remove rows with NA  
  informational_table <- na.omit(informational_table)  
  
  #Remove the rows with subset() to clean the data some 
  pers_tbl <- subset(informational_table, (gender != "unknown" & objectcount != 0 & datebegin != 0))  
  
  #Returning the good table 
  return(pers_tbl)  
}
```

`cultured_people`

Similar as before in `cultured_objects`, this function allows for the
addition of filtering through the cultures of each person in the API
records. This function has a similar input and output will look the same
as the `find_people` function except all records will be from one
specific culture.

``` r
#Calling the API for people based on what culture they are from
find_people <- function(key, culture){
my_data <- httr::GET("https://api.harvardartmuseums.org/person?q=culture:",culture,"&apikey=",key,"&size=30")  

#Turning this into a table that is readable in R
readable_table <- fromJSON(rawToChar(my_data$content))  

#Picking out the personid, displayname, gender, culture (to assure correctness), objectcount, and datebegin  
selected_table <- select(readable_table$records, personid, displayname, gender, culture, objectcount, datebegin)
}

#Printing out the table a little nicer as a tibble  
informational_table <- as_tibble(selected_table)

#Remove rows with NA  
informational_table <- na.omit(informational_table)  

#Remove the rows with unknowns in them
clean_tbl <- informational_table[-row(informational_table)[informational_table == "unknown"],]  

#Returning the cleaned table 
print(clean_tbl)
```

`person_gender`

My personal favorite would be this `person_gender` function. I could see
a lot of good data analysis coming from comparing the male to female
records in this binary gender option. The input here will be your API
key and then selecting male or female to retrun all the male data or all
the female data.

``` r
#Calling the API for people based on a binary gender model
person_gender <- function(key, gender){
    #Providing the base URL  
  base_URL <- "https://api.harvardartmuseums.org/person?apikey="  
  
  #Pasting together the API
  gen_pers_URL <- paste0(base_URL,key,"&q=gender:",gender)  
  
  #Pulling data from the API
  my_data <- httr::GET(gen_pers_URL)  

  #Turning this into a table that is readable in R
  readable_table <- fromJSON(rawToChar(my_data$content))  
 
  #Picking out the personid, displayname, gender (to assure correctness), objectcount, and datebegin  
  selected_table <- select(readable_table$records, personid, displayname, gender, objectcount, datebegin)

  #Printing out the table a little nicer as a tibble  
  informational_table <- as_tibble(selected_table)

  #Remove the rows with subset() to clean the data some 
  gen_pers_tbl <- subset(informational_table, (gender != "unknown" & objectcount != 0 & datebegin != 0))  
  
  #Returning the good table 
  return(gen_pers_tbl)  
}
```

## Go Wild for Expoloratory Data Analysis (EDA)

EDA is the most fun part of the API query journey! Now you can take
whatever data you chose and figure out the different relationships
between your specified options. Here I am going to analyze the
difference between male and female records. I want to see which of these
two genders appears more throughout time and how much each has. Commonly
today we hear how men take up most of different spaces and I want to see
if that applies to art at the museum as well. Do men hold the most space
at museums? Is there any time when there were more obejcts from women
than men? What is the average amount of object per man or woman?

``` r
#Using my find_people function to pull in data for this numerical summary  
pers_tbl <- find_people("1d505e26-5d36-4674-a35b-c40cab886778")  

#Must use the pagination function here to pull enough data to have a good sample amount  


#Selecting the specific columns I want to look at so summarise() does not clutter the table
gen_summary <- pers_tbl %>% 
              select(gender, objectcount) %>% 
              group_by(gender) %>% 
              summarise(mean = mean(objectcount),
                       sd = sd(objectcount),
                       min = min(objectcount),
                       max = max(objectcount),
                       IQR = IQR(objectcount))  

#Printing the summaries table
print(gen_summary)  
```

    ## # A tibble: 1 × 6
    ##   gender  mean    sd   min   max   IQR
    ##   <chr>  <dbl> <dbl> <int> <int> <dbl>
    ## 1 male       2    NA     2     2     0

``` r
#Making a boxplot of the summary statistics for a more visual look  
gen_plot1 <- ggplot(data = gen_summary, aes(x = "gender", y = "objectcount")) +
         geom_boxplot()
```

``` r
#Using the finc_people function to pull data for the contingency table  
pers_tbl <- find_people("1d505e26-5d36-4674-a35b-c40cab886778")  

#Must include the pagination function to get a large enough sample size  

#Creating a contingency table for gender and datebegin  
con_tbl_1 <- table(pers_tbl$gender, 
                  pers_tbl$datebegin)  
#Printing out the contingency table 
print(con_tbl_1)
```

    ##       
    ##        1812
    ##   male    1

``` r
#Using the finc_people function to pull data for the contingency table  
obj_tbl <- object_info("1d505e26-5d36-4674-a35b-c40cab886778")  
```

    ## # A tibble: 10 × 4
    ##    objectid century      culture  totalpageviews
    ##       <int> <chr>        <chr>             <int>
    ##  1    54767 20th century American              2
    ##  2    54768 20th century American              2
    ##  3    54769 20th century American              3
    ##  4    54770 20th century American              1
    ##  5    54771 20th century American              6
    ##  6    54772 20th century American              1
    ##  7    54773 20th century American              4
    ##  8    54774 20th century American              1
    ##  9    54775 20th century American              3
    ## 10    54776 20th century American              7

``` r
#Must include the pagination function to get a large enough sample size  

#Creating a contingency table for gender and datebegin  
con_tbl_2 <- table(obj_tbl$culture, 
                  obj_tbl$century)  
#Printing out the contingency table 
print(con_tbl_2)
```

    ##           
    ##            20th century
    ##   American           10

``` r
#Using person_gender() to pull only female records first
pers_tbl <- find_people("1d505e26-5d36-4674-a35b-c40cab886778")  

#Making a line plot off of the objectcount over time for each gender
obj_cnt_plot2 <- ggplot(pers_tbl, aes(x = datebegin, y = objectcount, color = gender)) + 
            geom_line()
```

This first graph is a count plot of men and women over time. Bigger
circles show that there are more of one gender throughout the dates.
This plot is not perfect to show us the artists in their time, but can
show us if there were more men or women at times based on their start
date.

``` r
#I would use the find_people call to get the right data frame for this one
#If provided the proper input, this would graph the count plot of the men and women during different datebegin
  ggplot((aes(x = "gender", y = "datebegin"))) + 
  geom_count(na.rm = TRUE, show.legend = TRUE) +
  labs(x="Gender", y="Date They Began", title="Popular Starts for Men vs. Women")
```

This graph is a bar plot of the number of objects that men and women
had. This is a very simple plot with two bars on it, but this is a
visual to see the overall amounts of each.

``` r
#I would use find_people function and group_by(gender) to compare the objectcount from men to women
#Plotting a bar graph
ggplot(df, aes(x = gender, y = objectcount)) +
  geom_bar() +
  labs(x="Gender", y="Ojbect Count", title ="Who Has More")
```

Here I look at the center and spread of both the women and men’s object
counts. This would directly answer my question of who takes up more
space overall in the data base, but I would also point out that there
were many records with “unknown” listed as their gender so these results
don’t tell the whole story.

``` r
#I would grab the womens table from the person_gender function to gather those stats  
womens_stats <- summary(clean_womens$objectcount)  

#Printing out the stats
print(womens_stats)  

#Then I would grab the mens table from the person_gender function to get those stats  
mens_stats <- summary(clean_mens)

#Printing out mens stats  
print(mens_stats)  
```
