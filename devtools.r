library(devtools)

# One time
use_mit_license()
use_r("sqlstrings")
use_readme_md()

# Dependencies
use_package("stringr")
use_package("fs")
use_package("readr")

# Tests
use_testthat()
use_test("sqlstrings")

# Workflow
load_all()
test()
document()
check()