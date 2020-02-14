# load libraries ----------------------------------------------------------

library(sparklyr)
library(data.table)
library(magrittr)
library(ggplot2)
library(DBI)
library(dplyr)
library(arrow)

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

cars <- copy_to(spark, mtcars)

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
  select(gear, am) %>% 
  group_by(gear, am) %>% 
  summarise(mn = mean(gear),
            n()
            )
