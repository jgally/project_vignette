Project 2
================

\##Open SKills API Vignette

### Necessary Libraries

``` r
library(httr) #using GET("URL") from this package to ping websites/ call our API (application programmming interfaces)  
library(jsonlite)  
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
#This is my first call of the API. My only resource on there is person and the filter is culture=American
my_data <- httr::GET("https://api.harvardartmuseums.org/person?q=culture:American&apikey=1d505e26-5d36-4674-a35b-c40cab886778")  

#checking how it looks
str(my_data, max.level=1)  
```

    ## List of 10
    ##  $ url        : chr "https://api.harvardartmuseums.org/person?q=culture:American&apikey=1d505e26-5d36-4674-a35b-c40cab886778"
    ##  $ status_code: int 200
    ##  $ headers    :List of 11
    ##   ..- attr(*, "class")= chr [1:2] "insensitive" "list"
    ##  $ all_headers:List of 1
    ##  $ cookies    :'data.frame': 0 obs. of  7 variables:
    ##  $ content    : raw [1:5541] 7b 22 69 6e ...
    ##  $ date       : POSIXct[1:1], format: "2023-10-11 05:47:11"
    ##  $ times      : Named num [1:6] 0 0.461 0.487 0.522 0.566 ...
    ##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
    ##  $ request    :List of 7
    ##   ..- attr(*, "class")= chr "request"
    ##  $ handle     :Class 'curl_handle' <externalptr> 
    ##  - attr(*, "class")= chr "response"

``` r
#Turning this into a table that is readable in R
readable_table <- fromJSON(rawToChar(my_data$content))  

#Printing the first page of info to look at
readable_table
```

    ## $info
    ## $info$totalrecordsperquery
    ## [1] 10
    ## 
    ## $info$totalrecords
    ## [1] 5415
    ## 
    ## $info$pages
    ## [1] 542
    ## 
    ## $info$page
    ## [1] 1
    ## 
    ## $info$`next`
    ## [1] "https://api.harvardartmuseums.org/person?q=culture%3AAmerican&apikey=1d505e26-5d36-4674-a35b-c40cab886778&page=2"
    ## 
    ## $info$responsetime
    ## [1] "7 ms"
    ## 
    ## 
    ## $records
    ##     gender displaydate objectcount
    ## 1  unknown        <NA>           0
    ## 2     male   born 1950           4
    ## 3  unknown   1847-1920           1
    ## 4     male 1935 - 2009          27
    ## 5   female   1942-2011           3
    ## 6   female 1958 - 2010           3
    ## 7  unknown        <NA>           0
    ## 8  unknown        <NA>           0
    ## 9     male   born 1949           1
    ## 10 unknown   1794-1878           1
    ##                                                                roles
    ## 1                  Donor/Lender/Vendor, Artist, object, object, 1, 1
    ## 2                  Donor/Lender/Vendor, Artist, object, object, 1, 5
    ## 3                    Author, Artist after, publication, object, 1, 1
    ## 4                Artist, Donor/Lender/Vendor, object, object, 27, 21
    ## 5               Donor/Lender/Vendor, Artist, object, object, 2840, 3
    ## 6                  Donor/Lender/Vendor, Artist, object, object, 3, 3
    ## 7                  Artist, Donor/Lender/Vendor, object, object, 1, 1
    ## 8                                             Author, publication, 2
    ## 9  Artist, Author, Curator, object, publication, exhibition, 1, 4, 1
    ## 10                                                 Sitter, object, 2
    ##    dateend                                                       url
    ## 1        0  https://www.harvardartmuseums.org/collections/person/110
    ## 2        0  https://www.harvardartmuseums.org/collections/person/151
    ## 3     1920  https://www.harvardartmuseums.org/collections/person/628
    ## 4     2009  https://www.harvardartmuseums.org/collections/person/673
    ## 5     2011  https://www.harvardartmuseums.org/collections/person/818
    ## 6     2010  https://www.harvardartmuseums.org/collections/person/825
    ## 7        0 https://www.harvardartmuseums.org/collections/person/1125
    ## 8        0 https://www.harvardartmuseums.org/collections/person/1356
    ## 9     9999 https://www.harvardartmuseums.org/collections/person/1358
    ## 10    1878 https://www.harvardartmuseums.org/collections/person/1613
    ##      birthplace datebegin  culture             displayname
    ## 1          <NA>         0 American         Cathryn Griffin
    ## 2          <NA>      1950 American             Mark Cooper
    ## 3          <NA>      1847 American  Alfred William Parsons
    ## 4  New York, NY      1935 American           Michael Mazur
    ## 5          <NA>      1942 American Susan Wilmarth-Rabineau
    ## 6          <NA>      1958 American          Kate Freedberg
    ## 7          <NA>         0 American           Patti Capaldi
    ## 8          <NA>         0 American           Robert Taylor
    ## 9  Portland, ME      1949 American            Robert Storr
    ## 10         <NA>      1794 American   William Cullen Bryant
    ##                   alphasort personid         deathplace   id
    ## 1          Griffin, Cathryn      110               <NA>  110
    ## 2              Cooper, Mark      151               <NA>  151
    ## 3   Parsons, Alfred William      628               <NA>  628
    ## 4            Mazur, Michael      673   Cambridge, Mass.  673
    ## 5  Wilmarth-Rabineau, Susan      818 New York, New York  818
    ## 6           Freedberg, Kate      825               <NA>  825
    ## 7            Capaldi, Patti     1125               <NA> 1125
    ## 8            Taylor, Robert     1356               <NA> 1356
    ## 9             Storr, Robert     1358               <NA> 1358
    ## 10   Bryant, William Cullen     1613               <NA> 1613
    ##                  lastupdate                                 names
    ## 1  2023-10-10T09:16:13-0400                                  NULL
    ## 2  2023-10-10T09:16:52-0400             Mark Cooper, Primary Name
    ## 3  2023-10-10T09:16:15-0400  Alfred William Parsons, Primary Name
    ## 4  2023-10-10T09:16:58-0400           Michael Mazur, Primary Name
    ## 5  2023-10-10T09:15:52-0400 Susan Wilmarth-Rabineau, Primary Name
    ## 6  2023-10-10T09:14:41-0400          Kate Freedberg, Primary Name
    ## 7  2023-10-10T09:14:35-0400                                  NULL
    ## 8  2023-10-10T09:16:48-0400                                  NULL
    ## 9  2023-10-10T09:15:13-0400            Robert Storr, Primary Name
    ## 10 2023-10-10T09:16:46-0400   William Cullen Bryant, Primary Name
    ##    wikipedia_id wikidata_id   viaf_id   ulan_id
    ## 1          <NA>        <NA>      <NA>      <NA>
    ## 2      46909763        <NA>      <NA>      <NA>
    ## 3          <NA>        <NA>      <NA>      <NA>
    ## 4      38497254    Q6832612  72274142 500094336
    ## 5          <NA>        <NA>      <NA>      <NA>
    ## 6          <NA>        <NA>      <NA>      <NA>
    ## 7          <NA>        <NA>      <NA>      <NA>
    ## 8          <NA>        <NA>      <NA>      <NA>
    ## 9       7309115        <NA> 110730421 500461115
    ## 10         <NA>        <NA>      <NA>      <NA>

``` r
#Picking which columns I want to work with
selected_table <- select(readable_table$records, gender, objectcount, datebegin)
```

So you like art. You like the art that is in the Harvard Art Museum. You
want to know the numbers and data behind the art in the museum. The
Harvard Art Museum API is the resource for you. This vignette is the
resouce to make your API data dive easier!

How to Query the Harvard Art API

There’s many parts to obtaining the data from an API so I wrote a couple
functions to ease your stress.

`composing_URL` I made this function to simplify the process of writing
the correct API URL. In my experience, making sure the syntax on the API
call is correct can be daunting when starting out. Good thing that the
Harvard Art Museum API is very beginner friendly! There is plenty of
good documentation to explain the database so figuring out what
“resource” or “filtering” that you would like to observe isn’t so
difficult.

In this function the inputs are “resource”, “filtering”, and “key”. All
three of these inputs must to be entered as a character string with
quotes around the option. Options of the filters must be input with the
specific search, so if I only wanted to observe American work I would
input “culture:American”. If there is You also must sign up on the
Harvard Art Museum API for your personal API key.

``` r
#This function will return the URL to use to access the correct API endpoint
composing_URL <- function(resource, key, filtering = "na"){
  my_URL <- if(filtering != "na"){
    print(paste0("https://api.harvardartmuseums.org/",resource,"?q=",filtering,"&apikey=",key))}
    else{
      print(paste0("https://api.harvardartmuseums.org/",resource,"&apikey=",key))
    }
}
```

`get_parsed` This function helps to call and parse the data into a
readable R object
