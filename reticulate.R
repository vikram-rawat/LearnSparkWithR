library(reticulate)
library(magrittr)

use_python("/usr/local/bin/python")
use_virtualenv("myenv")

os <- import("os")
os$listdir(".")

source_python("python/baseScripts.py")

use_virtualenv("myenv")

x <- c(123.1, 11.2, 1, 12, 12, 1)
y <- c(11.2, 12, 12)
z <- c(15, 16)

intersect(x, y)
union(x, z)

Vectorize(
    sum
  )(
  1:10,
  1:10,
  1:10,
  1:10
)