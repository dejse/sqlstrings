library(R6)
library(fs)
library(readr)
library(stringr)

SQLStrings <- R6Class("SQLStrings", 
  public = list(
    path = NULL,

    initialize = function(path) {
      self$path <- path
    },

    m = function() {
      print(private$parse_text())
    }
  ),
  private = list(
    get_all_files = function() {
      files <- self$path
      if (fs::dir_exists(self$path)) {
        files <- fs::dir_ls(self$path)
      }
      return(files)
    },

    read_all_files = function() {
      files <- private$get_all_files()
      txt <- ""
      for (f in seq_along(files)) {
        txt <- c(txt, readr::read_lines(files[f]))
      }
      return(txt)
    },

    parse_text = function() {
      txt <- private$read_all_files()
      is_name <- stringr::str_detect(txt, "-- name:")
      for (t in seq_along(is_name)) {
        if (is_name[t]) {
          
        }
      }
      return(t)
    }
  )
)

generate_sql_strings <- function(path) {
  return(SQLStrings$new(path))
}

generate_sql_strings("P:/++Work/Dev/DWHR/sql/sqlite/")$m()
#generate_sql_strings("P:/++Work/Dev/DWHR/sql/sqlite/01.sql")$m()
