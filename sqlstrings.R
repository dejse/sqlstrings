library(fs)
library(readr)
library(stringr)


generate_sql_strings <- function(path) {

  read_all_files <- function(path) {
    if (fs::dir_exists(path)) {
      path <- fs::dir_ls(path)
    }
    txt <- ""
    for (f in seq_along(path)) {
      txt <- c(txt, readr::read_lines(path[f]))
    }
    return(txt)
  }
  
  sql <- list()
  txt <- read_all_files(path)
  prefix <- stringr::str_c("-- ", "name", ": ")
  pos <- stringr::str_locate(txt, prefix)
  pos_of_names <- which(!is.na(pos[,1]))

  parse_function_name <- function(txt_line, prefix) {
    prefix_end <- stringr::str_length(prefix)
    sql_name <- stringr::str_trim(stringr::str_sub(txt_line, start = prefix_end))
    sql_name <- stringr::str_replace_all(sql_name, " ", "_")
    return(sql_name)
  }

  for (p in seq_along(pos_of_names)) {
    # Parse statement name
    n <- parse_function_name(txt[pos_of_names[p]], prefix)

    # Parse statement
    start <- pos_of_names[p] + 1
    end <- pos_of_names[p + 1] - 1
    if (p == length(pos_of_names)) {
      end <- length(txt)
    }
    stmt <- stringr::str_c(txt[start:end], collapse = "\n")

    # construct list
    sql[[n]] <- stmt
    #e <- stringr::str_glue("sql${n} <- stmt")
    #eval(str2expression(e))
  }

  print(sql)

}

path = "P:/++Work/Dev/DWHR/sql/sqlite/"

### Tests
generate_sql_strings("P:/++Work/Dev/DWHR/sql/sqlite/")
