### Helper Functions ### 
create_test_files <- function(tmp = tempdir(check = TRUE)) {
  fs::dir_create(fs::path(tmp, "test-folder"))
  fs::dir_create(fs::path(tmp, "test-folder2"))
  fs::file_create(fs::path(tmp, "test-folder", "file.txt"))
  fs::file_create(fs::path(tmp, "test-folder", "file2.txt"))
}

add_sql_code <- function(tmp = tempdir(check = TRUE)) {
  readr::write_lines("
  -- name: create
  create table tab1 (
    id integer primary key,
    city text unique not null,        -- comment
    pop integer
  );
  -- name: select
  select * from tab1;
  ", fs::path(tmp, "test-folder", "file.txt"))

  readr::write_lines("
  -- name: insert
  insert into tab1 values 
    (1, 'Berlin', 3),
    (2, 'Paris', 2),
    (3, 'London', 8);
  -- name: select_count
  select count(*) from tab1;
  ", fs::path(tmp, "test-folder", "file2.txt"))
}

delete_test_files <- function(tmp = tempdir(check = TRUE)) {
  fs::dir_delete(fs::path(tmp, "test-folder"))
  fs::dir_delete(fs::path(tmp, "test-folder2"))
}
