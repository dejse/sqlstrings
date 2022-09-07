test_that("Parsing paths work correctly", {
  # before
  tmp <- tempdir(check = TRUE)
  create_test_files(tmp)

  # tests
  expect_error(generate_sql_strings("./does-not-exist/"))
  expect_error(generate_sql_strings("./does-not-exist/file2.txt"))
  expect_error(generate_sql_strings())
  expect_equal(generate_sql_strings(fs::path(tmp, "test-folder2")), list())

  # after
  delete_test_files(tmp)
})


test_that("Parsing SQL Code works correctly", {
  # before
  tmp <- tempdir(check = TRUE)
  create_test_files(tmp)
  add_sql_code(tmp)
  s <- generate_sql_strings(fs::path(tmp, "test-folder"))

  # tests
  expect_true("create_tab1" %in% names(s))
  expect_true("select" %in% names(s))
  expect_true("insert_tab1" %in% names(s))
  expect_true("select_count" %in% names(s))
  expect_equal(s$create_tab1, "create table tab1 (\n    id integer primary key,\n    city text unique not null,        -- comment\n    pop integer\n  );")
  expect_equal(s$select, "select * from tab1;")
  expect_equal(s$insert_tab1, "insert into tab1 values \n    (1, 'Berlin', 3),\n    (2, 'Paris', 2),\n    (3, 'London', 8);")
  expect_equal(s$select_count, "select count(*) from tab1;")

  # after
  delete_test_files(tmp)
})