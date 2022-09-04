test_that("Error, when file or folder does not exist", {
  # before
  fs::dir_create("./test-folder")
  fs::file_create("./test-folder/file.txt")

  # tests
  expect_error(generate_sql_strings("./does-not-exist/"))
  expect_error(generate_sql_strings("./does-not-exist/file2.txt"))
  expect_error(generate_sql_strings())
  expect_equal(generate_sql_strings("./test-folder"), list())

  # after
  fs::dir_delete("./test-folder")
})


test_that("SQL Parsing works", {
  # before 

  # tests

  # after
})