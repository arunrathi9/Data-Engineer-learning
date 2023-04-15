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
libraryDependencies += "org.apache.spark" %% "spark-core" % "2.2.1"
libraryDependencies += "org.apache.spark" %% "spark-core" % "2.2.1"
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

  
![8 10](https://user-images.githubusercontent.com/27626791/232188956-b9e1e271-d322-4d12-bdc0-64e0a99bad8c.JPG)
