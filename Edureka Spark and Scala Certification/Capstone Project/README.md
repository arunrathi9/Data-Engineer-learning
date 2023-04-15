# Edureka: Apache Spark And Scala Capstone Project

## Project Name - Bicycle Sharing Demand (Domain: Transportation Industry)

### Business Challenge/requirement

<p>
</p>

### Project code

#### Data Exploration and Transformation

**1. Copying dataset to HDFS to execute:**<br>
<p>
hadoop fs -mkdir -p capstone_project/bicycle # create directory in hadoop

hdfs dfs -put *.csv capstone_project/bicycle # load data from local file system to hadoop/hdfs

hadoop fs -ls capstone_project/bicycle/ # list the files in hdfs
</p>
<img width="1159" alt="Screenshot 2023-04-13 at 10 36 02 PM" src="https://user-images.githubusercontent.com/27626791/231833344-11ee7f5c-ac22-4530-ba66-c097a36193ae.png">

**2. Read dataset in Spark**:
```
val trainDF = spark.read.format("csv").option("header", "true").option("delimiter", ",").option("inferschema", "true").l
oad("capstone_project/bicycle/train.csv")

```
<img width="1233" alt="Screenshot 2023-04-13 at 10 51 02 PM" src="https://user-images.githubusercontent.com/27626791/231836716-3db8fcb6-3f80-42cf-806a-2e77fef1a3ad.png">
<img width="948" alt="Screenshot 2023-04-13 at 10 51 20 PM" src="https://user-images.githubusercontent.com/27626791/231836753-d719cea5-fbff-4801-82aa-9be3660cd9be.png">
<img width="951" alt="Screenshot 2023-04-13 at 10 51 36 PM" src="https://user-images.githubusercontent.com/27626791/231836783-22ab323a-0b3c-4328-970a-de4f7a1a8aa9.png">
<img width="811" alt="Screenshot 2023-04-13 at 10 51 49 PM" src="https://user-images.githubusercontent.com/27626791/231836808-41b7e9f6-7a5a-42e8-b4d8-5b087314296a.png">
<img width="685" alt="Screenshot 2023-04-13 at 10 51 58 PM" src="https://user-images.githubusercontent.com/27626791/231836825-6fd7bb1e-be9f-449d-9662-5d02435c44aa.png">

<br>**3. Decide which columns should be categorical and then convert them accordingly**<br>
```
import org.apache.spark.sql.types.StringType

val tr_trainDF = trainDF.withColumn("season", trainDF("season").cast(StringType)).withColumn("holiday",trainDF("holiday").cast(StringType)).withColumn("workingday", trainDF("workingday").cast(StringType)).withColumn("weather", trainDF("weather").cast(StringType))

tr_trainDF.show(10)
```
<img width="1226" alt="Screenshot 2023-04-13 at 11 18 14 PM" src="https://user-images.githubusercontent.com/27626791/231842448-ec7cb425-c62c-47ab-af9f-9579a6aba77b.png">

**4. Check for any missing value in dataset and treat it**

```
trainDF.select(trainDF.columns.map(c => sum(col(c).isNull.cast("int")).alias(c)):_*).show
```
<img width="1022" alt="Screenshot 2023-04-13 at 11 21 01 PM" src="https://user-images.githubusercontent.com/27626791/231842982-ee622ba9-bfe9-4a19-a830-ec424a9712ce.png">

**5. Explode season column into separate columns such as season_<val> and drop season**
```
val season_trainDF= tr_trainDF.withColumn("season_1", when($"season"===1,1).otherwise(0)).withColumn("season_2",when($"season"===2,1).otherwise(0)).withColumn("season_3", when($"season"===3,1).otherwise(0)).withColumn("season_4",when($"season"===4,1).otherwise(0)).drop("season")

season_trainDF.show(10)
```
<img width="1240" alt="Screenshot 2023-04-13 at 11 28 22 PM" src="https://user-images.githubusercontent.com/27626791/231844695-0fcb18f5-1e65-4d0d-8aa3-5edd3a7d88fb.png">

**6. Execute the same for weather as weather_<val> and drop weather**

```
val weather_trainDF= season_trainDF.withColumn("weather_1", when($"weather"===1,1).otherwise(0)).withColumn("weather_2",when($"weather"===2,1).otherwise(0)).withColumn("weather_3", when($"weather"===3,1).otherwise(0)).withColumn("weather_4",when($"weather"===4,1).otherwise(0)).drop("weather")

weather_trainDF.show(10)
```
<img width="1247" alt="Screenshot 2023-04-13 at 11 34 59 PM" src="https://user-images.githubusercontent.com/27626791/231845996-68888c29-d7fc-4886-8b90-064bd749b2a3.png">


**7. Split datetime in to meaning columns such as hour, day, month, year, etc.**

```
val df_time = weather_trainDF.withColumn("datetime", to_timestamp(col("datetime"), "d-M-y H:m"))
val datetime_trainDF = df_time.withColumn("year", year(col("datetime"))).withColumn("month", month(col("datetime"))).withColumn("day", year(col("datetime")))
```
<img width="1240" alt="Screenshot 2023-04-14 at 11 02 41 AM" src="https://user-images.githubusercontent.com/27626791/231949988-7a3569f6-20a1-49a4-931b-2b91a2fd34a6.png">

**8. Explore how count varies with different features such as hour, month, etc.**

```
datetime_trainDF.groupBy("year").count.show
datetime_trainDF.groupBy("month").count.show
datetime_trainDF.groupBy("day").count.show
```
![8 1](https://user-images.githubusercontent.com/27626791/232188858-ea755b21-bbf5-451d-bc5c-3bdeda214429.JPG)
![8 2](https://user-images.githubusercontent.com/27626791/232188906-dc2f1d8b-2f75-4d14-9d8d-59243eec6de5.JPG)
![8 3](https://user-images.githubusercontent.com/27626791/232188915-f914978d-1169-419b-85b7-ae8f2bf5ce69.JPG)


  
#### Model Development
  
  **1. Split the dataset into train and train_test**
  
  ```
  val splitSeed = 123
  val Array(train, train_test) = datetime_trainDF.randomSplit(Array(0.7, 0.3), splitSeed)
  ```
  
  **2. Try different regression algorithms such as linear regression, random forest, etc. and note 
accuracy.**
  ```
  import org.apache.spark.ml.feature.StringIndexer
val indexer1 = { new StringIndexer().setInputCol("holiday").setOutputCol("holidayIndex") }
val indexer2 = { new 
StringIndexer().setInputCol("workingday").setOutputCol("workingdayIndex") }
import org.apache.spark.ml.feature.VectorAssembler
val assembler = { new VectorAssembler().setInputCols(Array("holidayIndex","workingdayIndex","temp","atemp","humidity","windspeed","season_1","season_2","season_3","season_4","weather_1","weather_2","weather_3","weather_4","month","day","year")).setOutputCol("features") }

  
//Linear Regression Model
import org.apache.spark.ml.regression.LinearRegression
val lr = { new LinearRegression().setMaxIter(10).setRegParam(0.3).setElasticNetParam(0.8).setLabelCol("count").setFeaturesCol("features") }
import org.apache.spark.ml.Pipeline
val pipeline = new Pipeline().setStages(Array(indexer1, indexer2, assembler, lr))

val lr_model = pipeline.fit(train)
val predictions = lr_model.transform(train_test)
import org.apache.spark.ml.evaluation.RegressionEvaluator
val evaluator = { new RegressionEvaluator().setLabelCol("count").setPredictionCol("prediction").setMetricName("rmse") }
val rmse = evaluator.evaluate(predictions)
println("LinearRegression Root Mean Squared Error (RMSE) on test data = " + rmse)

import org.apache.spark.ml.regression.GeneralizedLinearRegression
val glr = { new GeneralizedLinearRegression().setFamily("gaussian").setLink("identity").setMaxIter(10).setRegParam(0.3).setLabelCol("count").setFeaturesCol("features") }
val pipeline = new Pipeline().setStages(Array(indexer1, indexer2, assembler, glr))
val glr_model = pipeline.fit(train)

val predictions = glr_model.transform(train_test)
val evaluator = { new RegressionEvaluator().setLabelCol("count").setPredictionCol("prediction").setMetricName("rmse") }
val rmse = evaluator.evaluate(predictions)
println("GeneralizedLinearRegression Root Mean Squared Error (RMSE) on test data = " + rmse)

//Decision Tree Regressor Model
import org.apache.spark.ml.regression.DecisionTreeRegressor
val dt = { new DecisionTreeRegressor().setLabelCol("count").setFeaturesCol("features") }
val pipeline = new Pipeline().setStages(Array(indexer1, indexer2, assembler, dt))
val dt_model = pipeline.fit(train)
val predictions = dt_model.transform(train_test)
val evaluator = { new RegressionEvaluator().setLabelCol("count").setPredictionCol("prediction").setMetricName("rmse") }
val rmse = evaluator.evaluate(predictions)
println("DecisionTreeRegressor Root Mean Squared Error (RMSE) on test data = " + rmse)

//Random Forest Regressor Model
import org.apache.spark.ml.regression.{RandomForestRegressionModel, RandomForestRegressor}
val rf = { new RandomForestRegressor().setLabelCol("count").setFeaturesCol("features") }
val pipeline = new Pipeline().setStages(Array(indexer1, indexer2, assembler, rf))
val rf_model = pipeline.fit(train)
val predictions = rf_model.transform(train_test)
val evaluator = { new RegressionEvaluator().setLabelCol("count").setPredictionCol("prediction").setMetricName("rmse") }
val rmse = evaluator.evaluate(predictions)
println("RandomForestRegressor Root Mean Squared Error (RMSE) on test data = " + rmse)

//GBT Regressor Model
import org.apache.spark.ml.regression.{GBTRegressionModel, GBTRegressor}
val gbt = { new GBTRegressor().setLabelCol("count").setFeaturesCol("features").setMaxIter(10)}
val pipeline = new Pipeline().setStages(Array(indexer1, indexer2, assembler, gbt))
val gbt_model = pipeline.fit(train)
val predictions = gbt_model.transform(train_test)
val evaluator = { new RegressionEvaluator().setLabelCol("count").setPredictionCol("prediction").setMetricName("rmse") }
val rmse = evaluator.evaluate(predictions)
println("GBTRegressor Root Mean Squared Error (RMSE) on test data = " + rmse)

import org.apache.spark.ml.regression.IsotonicRegression
val ir = { new IsotonicRegression().setLabelCol("count").setFeaturesCol("features") }
val pipeline = new Pipeline().setStages(Array(indexer1, indexer2, assembler, ir))
val ir_model = pipeline.fit(train)
val predictions = ir_model.transform(train_test)
val evaluator = { new RegressionEvaluator().setLabelCol("count").setPredictionCol("prediction").setMetricName("rmse") }
val rmse = evaluator.evaluate(predictions)
println("IsotonicRegression Root Mean Squared Error (RMSE) on test data = " + rmse)
  ```
 ![8 4](https://user-images.githubusercontent.com/27626791/232188926-c2982e15-03d6-400a-8c04-f5e7118638a3.JPG)
![8 5](https://user-images.githubusercontent.com/27626791/232188935-787e8802-64c3-4f09-9f08-8aadf534eaa8.JPG)
![8 6](https://user-images.githubusercontent.com/27626791/232188941-620ccc8d-696a-453e-909f-94e9809f1aa3.JPG)
![8 7](https://user-images.githubusercontent.com/27626791/232188947-ecab274a-f07f-4cf9-bbe3-6b794822510f.JPG)
![8 8](https://user-images.githubusercontent.com/27626791/232188950-77feae06-e603-4b24-b27b-244acb737932.JPG)
![8 9](https://user-images.githubusercontent.com/27626791/232188954-86e7d3ea-9d0d-4214-9a87-f861b099ef4f.JPG)
  
  **3. Select the best model and persist it**
  ```
gbt_model.write.overwrite().save("capstone_project/bicycle/ModelDevelopment")
  ```
  <img width="1212" alt="modelDevelopment" src="https://user-images.githubusercontent.com/27626791/232190352-f60aed12-9c87-41dc-887f-c6e68ec9f54c.png">

#### Model Implementation and Prediction
  
  **1. CREATE table Predictions to record the model performance**
  ```
  mysql -u arunrathit38edu -p
  
  use arunrathit38edu;
  
  CREATE TABLE predictions (datetime datetime, count FLOAT);
  ```
  <img width="888" alt="mysql1" src="https://user-images.githubusercontent.com/27626791/232190732-fdce85cb-b1f5-4666-bb6f-8a3c5ef9c586.png">
  <img width="802" alt="mysql2" src="https://user-images.githubusercontent.com/27626791/232190735-dd239b76-c93b-49d9-b963-5f89559d03c6.png">
 
  **2. create a build.sbt file with below content in path /home/arunrathit38edu/BicycleProject**
  ```
name := "Telecom"
version := "1.0"
scalaVersion := "2.11.8"
libraryDependencies += "org.apache.spark" %% "spark-core" % "2.2.1"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.2.1"
libraryDependencies += "org.apache.spark" %% "spark-mllib" % "2.2.1"
  ```
  
  **3. create scala file under “/home/arunrathit38edu/BicycleProject/src/main/scala”**
  ```
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.SparkContext._
import org.apache.spark.sql._
import org.apache.spark.sql.types._
import org.apache.spark.sql.functions._
import org.apache.spark.ml.regression.{GBTRegressionModel, GBTRegressor}
import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.spark.ml.feature.{StringIndexer, VectorAssembler}
import org.apache.spark.ml._
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.Pipeline
import org.apache.spark.ml.feature.OneHotEncoder
  
object BicyclePredict {
def main(args: Array[String]) {
val sparkConf = new SparkConf().setAppName("Telecom")
val sc = new SparkContext(sparkConf)
sc.setLogLevel("ERROR")
val spark = new org.apache.spark.sql.SQLContext(sc)
import spark.implicits._
println("Reading training data...")
  
val trainDF = spark.read.format("csv").option("header", "true").option("delimiter", ",").option("inferSchema", true).load("capstone_project/bicycle/train.csv")
  
println("Cleaning data...")
import org.apache.spark.sql.types.StringType
val tr_trainDF = trainDF.withColumn("season", trainDF("season").cast(StringType)).withColumn("holiday", trainDF("holiday").cast(StringType)).withColumn("workingday", trainDF("workingday").cast(StringType)).withColumn("weather", trainDF("weather").cast(StringType))
  
val season_trainDF = tr_trainDF.withColumn("season_1", when($"season"===1,1).otherwise(0)).withColumn("season_2", when($"season"===2,1).otherwise(0)).withColumn("season_3", when($"season"===3,1).otherwise(0)).withColumn("season_4",when($"season"===4,1).otherwise(0)).drop("season")
  
val weather_trainDF = season_trainDF.withColumn("weather_1", when($"weather"===1,1).otherwise(0)).withColumn("weather_2", when($"weather"===2,1).otherwise(0)).withColumn("weather_3", when($"weather"===3,1).otherwise(0)).withColumn("weather_4", when($"weather"===4,1).otherwise(0)).drop("weather")
  
val df_time = weather_trainDF.withColumn("datetime", to_timestamp(col("datetime"), "d-M-y H:m"))
val datetime_trainDF = df_time.withColumn("year", year(col("datetime"))).withColumn("month", month(col("datetime"))).withColumn("day", year(col("datetime")))

val splitSeed = 123
val Array(train, train_test) = datetime_trainDF.randomSplit(Array(0.7, 0.3), splitSeed)
  
import org.apache.spark.ml.feature.StringIndexer
val indexer1 = { new StringIndexer().setInputCol("holiday").setOutputCol("holidayIndex") }
val indexer2 = { new StringIndexer().setInputCol("workingday").setOutputCol("workingdayIndex") }
  
import org.apache.spark.ml.feature.VectorAssembler
val assembler = { new VectorAssembler().setInputCols(Array("holidayIndex","workingdayIndex","temp","atemp","humidity","windspeed","season_1","season_2","season_3","season_4","weather_1","weather_2","weather_3","weather_4","month","day","year")).setOutputCol("features") }
  
import org.apache.spark.ml.regression.{GBTRegressionModel, GBTRegressor}
val gbt = { new GBTRegressor().setLabelCol("count").setFeaturesCol("features").setMaxIter(10) }
val pipeline = new Pipeline().setStages(Array(indexer1, indexer2, assembler, gbt))

println("Training model...")
val gbt_model = pipeline.fit(train)
val predictions = gbt_model.transform(train_test)
val evaluator = { new RegressionEvaluator().setLabelCol("count").setPredictionCol("prediction").setMetricName("rmse") }
val rmse = evaluator.evaluate(predictions)
println("GBTRegressor Root Mean Squared Error (RMSE) on test data = " + rmse)

gbt_model.write.overwrite().save("capstone_project/ModelImplementation")
}
}
```
  
![8 10](https://user-images.githubusercontent.com/27626791/232188956-b9e1e271-d322-4d12-bdc0-64e0a99bad8c.JPG)

  
**4. submit the spark and run it for train data**
```
sbt package
spark-submit --class "BicyclePredict" --master yarn /home/arunrathit38edu/BicycleProject2/target/scala-2.11/telecom_2.11-1.0.jar
```
<img width="1242" alt="train-model-run" src="https://user-images.githubusercontent.com/27626791/232202680-314db9f6-115b-431a-98e4-465fc73d7da0.png">

   **5. create a build.sbt file with below content in path /home/arunrathit38edu/BicycleProject for test data**
  ```
  name := "Telecom"
version := "1.0"
scalaVersion := "2.11.8"
libraryDependencies += "org.apache.spark" %% "spark-core" % "2.2.1"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.2.1" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-mllib" % "2.2.1" % "provided"
  ```
  
**6. rewrite scala file under “/home/arunrathit38edu/BicycleProject/src/main/scala” for test predictions**
  ```
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.SparkContext._
import org.apache.spark.sql._
import org.apache.spark.sql.types._
import org.apache.spark.sql.functions._
import org.apache.spark.ml.regression.{GBTRegressionModel, GBTRegressor}
import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.spark.ml.feature.{StringIndexer, VectorAssembler}
import org.apache.spark.ml._
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.Pipeline
import org.apache.spark.ml.feature.OneHotEncoder

object BicyclePredict {
def main(args: Array[String]) {
val sparkConf = new SparkConf().setAppName("Telecom")
val sc = new SparkContext(sparkConf)
sc.setLogLevel("ERROR")
val spark = new org.apache.spark.sql.SQLContext(sc)
import spark.implicits._
println("Reading test data...")
val testDF = spark.read.format("csv").option("header", "true").option("delimiter", ",").option("inferSchema", true).load("capstone_project/bicycle/test.csv")

println("Cleaning data...")
import org.apache.spark.sql.types.StringType
val tr_testDF = testDF.withColumn("season", testDF("season").cast(StringType)).withColumn("holiday", testDF("holiday").cast(StringType)).withColumn("workingday", testDF("workingday").cast(StringType)).withColumn("weather", testDF("weather").cast(StringType))
  
val season_testDF = tr_testDF.withColumn("season_1", when($"season"===1,1).otherwise(0)).withColumn("season_2", when($"season"===2,1).otherwise(0)).withColumn("season_3", when($"season"===3,1).otherwise(0)).withColumn("season_4",when($"season"===4,1).otherwise(0)).drop("season")
  
val weather_testDF = season_testDF.withColumn("weather_1", when($"weather"===1,1).otherwise(0)).withColumn("weather_2", when($"weather"===2,1).otherwise(0)).withColumn("weather_3", when($"weather"===3,1).otherwise(0)).withColumn("weather_4", when($"weather"===4,1).otherwise(0)).drop("weather")
  
val df_time = weather_testDF.withColumn("datetime", to_timestamp(col("datetime"), "d-M-y H:m"))
val datetime_testDF = df_time.withColumn("year", year(col("datetime"))).withColumn("month", month(col("datetime"))).withColumn("day", year(col("datetime")))

println("Loading trained model...")
import org.apache.spark.ml.{Pipeline, PipelineModel}
val gbt_model = PipelineModel.read.load("capstone_project/ModelImplementation")

println("Making predictions...")
val predictions = gbt_model.transform(datetime_testDF).select($"datetime", $"prediction".as("count"))
println("Persisting the result to RDBMS...")
predictions.write.format("jdbc").option("url", "jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal/arunrathit38edu").option("driver", "com.mysql.cj.jdbc.Driver").option("dbtable", "predicQons").option("user", "arunrathit38edu").option("password", "<password>").mode(SaveMode.Append).save }}
  ```
  
    
**7. submit the spark and run it for test data**
```
sbt package
spark-submit --packages mysql:mysql-connector-java:8.0.13 --class "BicyclePredict" --master yarn /home/arunrathit38edu/BicycleProject2/target/scala-2.11/telecom_2.11-1.0.jar
```

<img width="1232" alt="test-run" src="https://user-images.githubusercontent.com/27626791/232202634-0747d082-61cd-456f-bcb7-f42a44ea7c56.png">
<img width="853" alt="test-run-result-in-database" src="https://user-images.githubusercontent.com/27626791/232202645-e8a61892-22e2-466e-8dc8-7f96e1d971ae.png">

#### Application for Streaming Data
  
  **1. Setup flume to push data into spark flume sink.**
  Create ‘project_hk_bicycle’ topic
  ```
kafka-topics --create --zookeeper ip-10-1-1-204.ap-south-1.compute.internal:2181 --replication-factor 1 --partitions 1 --topic project_hk_bicycle
  ```
  <img width="1234" alt="kafka1" src="https://user-images.githubusercontent.com/27626791/232202924-b7382323-78b4-4573-9ba7-2b1f7aaae909.png">
<img width="1241" alt="kafka2" src="https://user-images.githubusercontent.com/27626791/232202932-21abbccf-b0ff-4434-8935-0bebb70bc8be.png">

  
  **2. Check data should not be there in table**
  ```
  mysql -h ip-10-1-1-204.ap-south-1.compute.internal -u arunrathit38edu -p
  ```
  <img width="1232" alt="empty-db" src="https://user-images.githubusercontent.com/27626791/232203102-2f01168b-e9c5-43bf-9d20-40fafa88268f.png">
  
  **3. HDFS Source for loading data in pipeline**
  ```
  hadoop fs -ls capstone_project/ModelImplementation
  ```
  <img width="1169" alt="hdfs-source-check" src="https://user-images.githubusercontent.com/27626791/232205269-b257a3d0-8d15-4c75-ad58-102f38e5e4f9.png">

  
  **4. Start Flume agent**<br>
  creating a file
  ```
  agent1.sources = source1
agent1.channels = channel1
agent1.sinks = spark
agent1.sources.source1.type = org.apache.flume.source.kafka.KafkaSource
agent1.sources.source1.zookeeperConnect = ip-10-1-1-204.ap-south-1.compute.internal:2181
agent1.sources.source1.kafka.bootstrap.servers = ip-10-1-2-24.ap-south-1.compute.internal:9092
agent1.sources.source1.kafka.topics = project_hk_bicycle
agent1.sources.source1.kafka.consumer.group.id = project_hk_bicycle
agent1.sources.source1.channels = channel1
agent1.sources.source1.interceptors = i1
agent1.sources.source1.interceptors.i1.type = timestamp
agent1.sources.source1.kafka.consumer.timeout.ms = 100
agent1.channels.channel1.type = memory
agent1.channels.channel1.capacity = 10000
agent1.channels.channel1.transactionCapacity = 1000
agent1.sinks.spark.type = org.apache.spark.streaming.flume.sink.SparkSink
agent1.sinks.spark.hostname = ip-10-1-2-24.ap-south-1.compute.internal
agent1.sinks.spark.port = 4143
agent1.sinks.spark.channel = channel1
  ```
  
  
  **5. Running the flume agent**
  ```
  flume-ng agent --conf conf --conf-file hk_bicycle.conf --name agent1-Dflume.root.logger=DEBUG
  ```
  <img width="1230" alt="flume-agent" src="https://user-images.githubusercontent.com/27626791/232205302-661fcb59-0ff7-424d-a673-9051ed1b033e.png">

  **6. Create build.sbt file with code which is given below**
  ```
  name := "Telecom"
version := "1.0"
scalaVersion := "2.11.8"
libraryDependencies += "org.apache.spark" %% "spark-core" % "2.2.1"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.2.1" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-mllib" % "2.2.1" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-streaming" % "2.2.0" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-streaming-flume" % "2.4.8"
libraryDependencies += "org.apache.spark" %% "spark-streaming-kafka" % "1.6.0"
  ```
   **7. Create scala file with code which is given below**
  ```
  import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.SparkContext._
import org.apache.spark.sql._
import org.apache.spark.sql.types._
import org.apache.spark.sql.functions._
import org.apache.spark.ml.regression.{GBTRegressionModel, GBTRegressor}
import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.spark.ml.feature.{StringIndexer, VectorAssembler}
import org.apache.spark.ml._
import org.apache.spark.ml.feature.VectorAssembler
import org.apache.spark.ml.Pipeline
import org.apache.spark.ml.feature.OneHotEncoder
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.streaming.flume._


object BicycleStreaming {
case class Bicycle(datetime: String, season: Int, holiday: Int, workingday: Int, weather: Int, temp: Double, atemp: Double, humidity: Int, windspeed: Double)
def main(args: Array[String]) {
val sparkConf = new SparkConf().setAppName("Telecom")
val sc = new SparkContext(sparkConf)
val ssc = new StreamingContext(sc, Seconds(2))
sc.setLogLevel("ERROR")
val spark = new org.apache.spark.sql.SQLContext(sc)
import spark.implicits._
import org.apache.spark.streaming.flume._
val flumeStream = FlumeUtils.createPollingStream(ssc, "ip-10-1-1-204.ap-south-1.compute.internal", 4143)

println("Loading trained model...")
import org.apache.spark.ml.{Pipeline, PipelineModel}
val gbt_model = PipelineModel.read.load("capstone_project/ModelImplementation")
val lines = flumeStream.map(event => new String(event.event.getBody().array(), "UTF-8"))
lines.foreachRDD { rdd => def row(line: List[String]): Bicycle = Bicycle(line(0), line(1).toInt, line(2).toInt, line(3).toInt, line(4).toInt, line(5).toDouble, line(6).toDouble, line(7).toInt, line(8).toDouble )
val rows_rdd = rdd.map(_.split(",").to[List]).map(row)
val rows_df = rows_rdd.toDF
if(rows_df.count > 0) {
val tr_rowsDF = rows_df.withColumn("season", rows_df("season").cast(StringType)).withColumn("holiday", rows_df("holiday").cast(StringType)).withColumn("workingday", rows_df("workingday").cast(StringType)).withColumn("weather", rows_df("weather").cast(StringType))
val season_rowsDF = tr_rowsDF.withColumn("season_1", when($"season"===1,1).otherwise(0)).withColumn("season_2", when($"season"===2,1).otherwise(0)).withColumn("season_3", when($"season"===3,1).otherwise(0)).withColumn("season_4", when($"season"===4,1).otherwise(0)).drop("season")
val weather_rowsDF = season_rowsDF.withColumn("weather_1", when($"weather"===1,1).otherwise(0)).withColumn("weather_2", when($"weather"===2,1).otherwise(0)).withColumn("weather_3", when($"weather"===3,1).otherwise(0)).withColumn("weather_4", when($"weather"===4,1).otherwise(0)).drop("weather")
val datetime_rowsDF = weather_rowsDF.withColumn("year",year(from_unixtime(unix_timestamp($"datetime", "dd-mm- yyyy hh:mm")))).withColumn("month",month(from_unixtime(unix_timestamp($"datetime", "dd- mm-yyyy hh:mm")))).withColumn("day",dayofyear(from_unixtime(unix_timestamp($"datetime", "dd-mm-yyyy hh:mm"))))

println("Making predicQons...")
val predictions = gbt_model.transform(datetime_rowsDF).select($"datetime", $"prediction".as("count"))

println("PersisQng the result to RDBMS...")
predictions.write.format("jdbc").option("url", "jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal/arunrathit38edu").option("driver", "com.mysql.cj.jdbc.Driver").option("dbtable", "predictions").option("user", "arunrathit38edu").option("password", "<password>").mode(SaveMode.Append).save
}
}
ssc.start()
ssc.awaitTermination()
}
}
  ```
  
  **7. Run the package command**
  ```
  sbt package
  spark-submit --packages mysql:mysql-connector-java:8.0.13 --class "BicycleStreaming" --master yarn /home/arunrathit38edu/BicycleProject2/target/scala-2.11/telecom_2.11-1.0.jar
  ```
  
  **8. Run kafka-console-producer**
  ```
  kafka-console-producer --broker-list ip-10-1-1-204.ap-south-1.compute.internal:9092 --topic project_hk_bicycle
  ```
  <img width="1245" alt="kafka" src="https://user-images.githubusercontent.com/27626791/232206453-8f2b7bb9-9efb-49ed-8ce1-326eb54c6131.png">
<img width="1077" alt="kakfa-producer" src="https://user-images.githubusercontent.com/27626791/232206579-b8f733f3-dd15-4216-abc4-aa20839742eb.png">

  
  
  
