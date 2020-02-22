library(reticulate)
library(magrittr)

use_python("/usr/local/bin/python")
use_virtualenv("myenv")

os <- import("os")
os$listdir(".")

source_python("python/baseScripts.py")

use_virtualenv("myenv")

x <- student("vikram", "bcom", "commerce")
x$get_classn()
x$classn
x$name
x$subj