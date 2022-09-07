# sqlstrings

<!-- badges: start -->
<!-- badges: end -->

## Overview

Writing SQL Code in R files brings some disadvantages, such as losing syntax highlighting and autocomplete. With the help of `sqlstrings`, you can write SQL code in separate files and load the statements into R as a list object. 


## Installation

``` r
# Install released version from CRAN
install.packages("sqlstrings")

# Install developed version from GitHub
devtools::install_github("wiwirebell/sqlstrings")
```

## Example

Let's assume, we have a `./sql/` folder, containing files with the following code: 

```sql
-- name: create_tab1
create table tab1 (
  id integer primary key,
  city text unique not null,        -- comment
  pop integer
);

-- name: insert_into_tab1
insert into tab1 values 
  (1, 'Berlin', 3),
  (2, 'Paris', 2),
  (3, 'London', 8);

-- name: select_count
select count(*) from tab1;
```

In R, we can map the sql statements as strings to list attributes: 

```r
library(sqlstrings)
s <- generate_sql_strings("./sql/")
print(s)

## > print(s)
## $create_tab1
## [1] "create table tab1 (\n    id integer primary key,\n    city text unique not null,        -- comment\n    pop integer\n  );"
## 
## $insert_tab1
## [1] "insert into tab1 values \n    (1, 'Berlin', 3),\n    (2, 'Paris', 2),\n    (3, 'London', 8);"
## 
## $select_count
## [1] "select count(*) from tab1;"

DBI::dbExecute(con, s$create_tab1)
DBI::dbExecute(con, s$insert_tab1)
```