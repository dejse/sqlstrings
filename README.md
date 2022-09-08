# sqlstrings

<!-- badges: start -->
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/sqlstrings)](https://cran.r-project.org/package=sqlstrings)
<!-- badges: end -->

## Overview

Writing SQL code in R files is tedious for longer queries and statements and comes with certain disadvantages, such as losing syntax highlighting and autocomplete. With the help of `sqlstrings`, we can bulk read SQL code from a folder or a file and load it into an R list. The elements of the list are populated with the individual sql statements and queries. Before that, the SQL code must be annotated with a special name comment. 


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

-- name: insert_tab1
insert into tab1 values 
  (1, 'Berlin', 3),
  (2, 'Paris', 2),
  (3, 'London', 8);

-- name: select_count
select count(*) from tab1;
```

In R, we can load the SQL code into a list and its named elements will contain the individual queries:

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
```

Once the list is created, we can use the list, for example, with `DBI`:

```r
library(DBI)

# setup connection...

dbExecute(con, s$create_tab1)
dbExecute(con, s$insert_tab1)
dbGetQuery(con, s$select_count)
```
