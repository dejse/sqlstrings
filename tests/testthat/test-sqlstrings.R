test_that("Parsing paths work correctly", {
  # before
  create_test_files()

  # tests
  expect_error(generate_sql_strings("./does-not-exist/"))
  expect_error(generate_sql_strings("./does-not-exist/file2.txt"))
  expect_error(generate_sql_strings())
  expect_equal(generate_sql_strings("./test-folder2"), list())

  # after
  delete_test_files()
})


test_that("Parsing SQL Code works correctly", {
  # before
  create_test_files()
  add_sql_code()
  s <- generate_sql_strings("./test-folder")

  # tests
  expect_true("create" %in% names(s))
  expect_true("select" %in% names(s))
  expect_true("insert" %in% names(s))
  expect_true("select_count" %in% names(s))
  expect_equal(s$create, "create table tab1 (\n    id integer primary key,\n    city text unique not null,        -- comment\n    pop integer\n  );")
  expect_equal(s$select, "select * from tab1;")
  expect_equal(s$insert, "insert into tab1 values \n      (1, 'Berlin', 3),\n      (2, 'Paris', 2),\n      (3, 'London', 8);")
  expect_equal(s$select_count, "select count(*) from tab1;")

  # after
  delete_test_files()
})