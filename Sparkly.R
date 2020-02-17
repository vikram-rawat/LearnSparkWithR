# load libraries ----------------------------------------------------------

library(sparklyr)
library(data.table)
library(magrittr)
library(ggplot2)
library(DBI)
library(dplyr)
library(arrow)
library(inspectdf)
library(plotluck)
library(skimr)
library(ggfortify)

# set defaults ------------------------------------------------------------

setDTthreads(0L)
theme_set(theme_bw())

# use Spark ---------------------------------------------------------------

spark <- spark_connect(master = "local",
                       version = "3.0.0-preview")

# spark_available_versions()
# spark_versions()
# spark_installed_versions()
# spark_uninstall(version = "2.4.3",hadoop_version = "2.7")
# spark_install(version = "3.0.0-preview",hadoop_version = "3.2")
# spark_web(spark)

cars <- copy_to(spark, mtcars,overwrite = TRUE)

 ## use SQL Directly

spark %>% 
  dbGetQuery("select 
              gear,
              am,
              vs,
              carb,
              count(*) 
             from mtcars
             group by 
             gear,
             am,
             vs,
             carb")

  ## Use Dplyr Directly

cars %>%
  select(hp, mpg) %>%
  collect() %>%
  plotluck(hp ~ mpg,
           opts = plotluck.options(
             verbose = TRUE
             )
           )

model <- ml_linear_regression(cars, mpg ~ hp)

model %>% 
  summary()

model %>%
  ml_predict(
    copy_to(spark,
            data.frame(hp = 250 + 10 * 1:10)
            )
    ) %>%
  transmute(hp = hp, mpg = prediction) %>%
  full_join(select(cars, hp, mpg)) %>%
  collect() %>%
  plotluck(hp ~ mpg)


# spark_write_csv(x = cars,
#                 path =  "folder/cars.csv",
#                 header = TRUE,
#                 delimiter = ",")

# stream <- stream_read_csv(spark, "input/") %>%
#   select(mpg, cyl, disp) %>%
#   stream_write_csv("output/")

# stream_stop(stream)

spark_log(spark)

summarize_all(cars, mean)
summarize_all(mtcars, mean)
