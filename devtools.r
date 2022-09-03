library(devtools)

# One time
use_mit_license()
use_r("sqlstrings")
use_readme_rmd()

# Dependencies
use_package("stringr")
use_package("fs")

# Workflow
load_all()
document()
check()

# Tests
use_testthat()
use_test("sqlstrings")
test()