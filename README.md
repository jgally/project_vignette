Project 2
================

\##Open SKills API Vignette

### Necessary Libraries

``` r
library(httr) #using GET("URL") from this package to ping websites/ call our API (application programmming interfaces)  
library(jsonlite)  
library(dplyr)
```

``` r
#This is my first call of the API. My only resource on there is person and the filter is culture=American
my_data <- httr::GET("https://api.harvardartmuseums.org/person?q=culture:American&apikey=1d505e26-5d36-4674-a35b-c40cab886778")  

#checking how it looks
str(my_data, max.level=1)  
```

    ## List of 10
    ##  $ url        : chr "https://api.harvardartmuseums.org/person?q=culture:American&apikey=1d505e26-5d36-4674-a35b-c40cab886778"
    ##  $ status_code: int 200
    ##  $ headers    :List of 14
    ##   ..- attr(*, "class")= chr [1:2] "insensitive" "list"
    ##  $ all_headers:List of 1
    ##  $ cookies    :'data.frame': 0 obs. of  7 variables:
    ##  $ content    : raw [1:5542] 7b 22 69 6e ...
    ##  $ date       : POSIXct[1:1], format: "2023-10-11 17:31:10"
    ##  $ times      : Named num [1:6] 0 1.19 1.23 1.27 1.33 ...
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
    ## [1] "10 ms"
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
    ##                                                                roles dateend
    ## 1                  Donor/Lender/Vendor, Artist, object, object, 1, 1       0
    ## 2                  Donor/Lender/Vendor, Artist, object, object, 1, 5       0
    ## 3                    Artist after, Author, object, publication, 1, 1    1920
    ## 4                Donor/Lender/Vendor, Artist, object, object, 21, 27    2009
    ## 5               Donor/Lender/Vendor, Artist, object, object, 2840, 3    2011
    ## 6                  Artist, Donor/Lender/Vendor, object, object, 3, 3    2010
    ## 7                  Donor/Lender/Vendor, Artist, object, object, 1, 1       0
    ## 8                                             Author, publication, 2       0
    ## 9  Artist, Curator, Author, object, exhibition, publication, 1, 1, 4    9999
    ## 10                                                 Sitter, object, 2    1878
    ##                                                          url   birthplace datebegin
    ## 1   https://www.harvardartmuseums.org/collections/person/110         <NA>         0
    ## 2   https://www.harvardartmuseums.org/collections/person/151         <NA>      1950
    ## 3   https://www.harvardartmuseums.org/collections/person/628         <NA>      1847
    ## 4   https://www.harvardartmuseums.org/collections/person/673 New York, NY      1935
    ## 5   https://www.harvardartmuseums.org/collections/person/818         <NA>      1942
    ## 6   https://www.harvardartmuseums.org/collections/person/825         <NA>      1958
    ## 7  https://www.harvardartmuseums.org/collections/person/1125         <NA>         0
    ## 8  https://www.harvardartmuseums.org/collections/person/1356         <NA>         0
    ## 9  https://www.harvardartmuseums.org/collections/person/1358 Portland, ME      1949
    ## 10 https://www.harvardartmuseums.org/collections/person/1613         <NA>      1794
    ##     culture             displayname                alphasort personid
    ## 1  American         Cathryn Griffin         Griffin, Cathryn      110
    ## 2  American             Mark Cooper             Cooper, Mark      151
    ## 3  American  Alfred William Parsons  Parsons, Alfred William      628
    ## 4  American           Michael Mazur           Mazur, Michael      673
    ## 5  American Susan Wilmarth-Rabineau Wilmarth-Rabineau, Susan      818
    ## 6  American          Kate Freedberg          Freedberg, Kate      825
    ## 7  American           Patti Capaldi           Capaldi, Patti     1125
    ## 8  American           Robert Taylor           Taylor, Robert     1356
    ## 9  American            Robert Storr            Storr, Robert     1358
    ## 10 American   William Cullen Bryant   Bryant, William Cullen     1613
    ##            deathplace   id               lastupdate
    ## 1                <NA>  110 2023-10-11T10:33:15-0400
    ## 2                <NA>  151 2023-10-11T10:34:08-0400
    ## 3                <NA>  628 2023-10-11T10:33:48-0400
    ## 4    Cambridge, Mass.  673 2023-10-11T10:31:31-0400
    ## 5  New York, New York  818 2023-10-11T10:33:21-0400
    ## 6                <NA>  825 2023-10-11T10:32:04-0400
    ## 7                <NA> 1125 2023-10-11T10:31:58-0400
    ## 8                <NA> 1356 2023-10-11T10:34:23-0400
    ## 9                <NA> 1358 2023-10-11T10:32:41-0400
    ## 10               <NA> 1613 2023-10-11T10:34:16-0400
    ##                                    names wikipedia_id wikidata_id   viaf_id
    ## 1                                   NULL         <NA>        <NA>      <NA>
    ## 2              Mark Cooper, Primary Name     46909763        <NA>      <NA>
    ## 3   Alfred William Parsons, Primary Name         <NA>        <NA>      <NA>
    ## 4            Michael Mazur, Primary Name     38497254    Q6832612  72274142
    ## 5  Susan Wilmarth-Rabineau, Primary Name         <NA>        <NA>      <NA>
    ## 6           Kate Freedberg, Primary Name         <NA>        <NA>      <NA>
    ## 7                                   NULL         <NA>        <NA>      <NA>
    ## 8                                   NULL         <NA>        <NA>      <NA>
    ## 9             Robert Storr, Primary Name      7309115        <NA> 110730421
    ## 10   William Cullen Bryant, Primary Name         <NA>        <NA>      <NA>
    ##      ulan_id
    ## 1       <NA>
    ## 2       <NA>
    ## 3       <NA>
    ## 4  500094336
    ## 5       <NA>
    ## 6       <NA>
    ## 7       <NA>
    ## 8       <NA>
    ## 9  500461115
    ## 10      <NA>

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
