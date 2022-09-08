#' Read all files from path and return a list, where the list elements contain the individual 'SQL' statements and queries as strings
#' @param path A path to a folder or a file containing 'SQL' code
#' @return A list with named elements containing 'SQL' statements as strings
#' @examples 
#' ## prepare example file
#' p <- fs::path(tempdir(), "test-file-001.sql")
#' fs::file_create(p)
#' readr::write_lines("
#'   -- name: select_count
#'   select count(*) from tab1;
#' ", p)
#' 
#' ## sqlstrings
#' s <- generate_sql_strings(path = p)
#' s$select_count
#' @export
generate_sql_strings <- function(path = "") {

  # check if folder or file exists
  stopifnot("Folder or File does not exist" = fs::file_exists(path) || fs::dir_exists(path))
  path <- fs::path_real(path)
  sql <- list()

  # Read all files from path, concatenate into string vector
  # @param path A path to a folder or a file containing 'SQL' code
  # @return string vector
  read_all_files <- function(path) {
    txt <- ""
    if (fs::dir_exists(path)) {
      path <- fs::dir_ls(path)
    }
    for (f in seq_along(path)) {
      txt <- c(txt, readr::read_lines(path[f]))
    }
    return(txt)
  }
  
  txt <- read_all_files(path)
  prefix <- stringr::str_c("-- ", "name", ": ")
  line_pos_prefix <- which(!is.na(stringr::str_locate(txt, prefix)[,1]))

  # Parse 'SQL' statement name, given line and prefix (e.g. "-- name: my_statement")
  # @param line - 'SQL' code line 
  # @param prefix - string
  # @return string
  parse_function_name <- function(line, prefix) {
    prefix_end <- stringr::str_length(prefix)
    sql_name <- stringr::str_trim(stringr::str_sub(stringr::str_trim(line), start = prefix_end))
    sql_name <- stringr::str_replace_all(sql_name, " ", "_")
    return(sql_name)
  }

  # Construct list attributes with 'SQL' statement name and code
  for (i in seq_along(line_pos_prefix)) {
    # Parse statement name
    stmt_name <- parse_function_name(txt[line_pos_prefix[i]], prefix)

    # Parse statement
    start <- line_pos_prefix[i] + 1
    end <- line_pos_prefix[i + 1] - 1
    if (i == length(line_pos_prefix)) {
      end <- length(txt)
    }
    stmt <- stringr::str_trim(stringr::str_c(txt[start:end], collapse = "\n"))

    # construct list
    sql[[stmt_name]] <- stmt
  }
  
  return(sql)
}
