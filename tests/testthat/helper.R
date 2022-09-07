### Helper Functions ### 
create_test_files <- function() {
  fs::dir_create("./test-folder")
  fs::dir_create("./test-folder2")
  fs::file_create("./test-folder/file.txt")
  fs::file_create("./test-folder/file2.txt")
}

add_sql_code <- function() {
  readr::write_lines("-- name: create
  create table tab1 (
    id integer primary key,
    city text unique not null,        -- comment
    pop integer
  );
  ", "./test-folder/file.txt", append = TRUE)
  readr::write_lines("-- name: select
    select * from tab1;
  ", "./test-folder/file.txt", append = TRUE)

  readr::write_lines("-- name: insert
    insert into tab1 values 
      (1, 'Berlin', 3),
      (2, 'Paris', 2),
      (3, 'London', 8);
  ", "./test-folder/file2.txt", append = TRUE)

  readr::write_lines("-- name: select_count
    select count(*) from tab1;
  ", "./test-folder/file2.txt", append = TRUE)
}

delete_test_files <- function() {
  fs::dir_delete("./test-folder")
  fs::dir_delete("./test-folder2")
}
