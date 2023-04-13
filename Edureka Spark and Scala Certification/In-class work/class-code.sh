#Module 4 Deep Dive into Apache spark framework

# Create a folder layout for hello world program using spark and scala (for folder layout, check notes)
sbt package # to create the jar file
spark-submit --class "Hello" --master yarn /home/arunrathit38edu/Project/target/scala-2.11/hello-world_2.11-1.0.jar

vi metastore.db.script #to check last value of the selected column on w/c we are doing the incremental import

# Module 5 - Playing with RDD dataframes
# all code is in scala
a.glom.collect() # it will show the data partition wise
a.getNumPartitions # to get the number of partitions
