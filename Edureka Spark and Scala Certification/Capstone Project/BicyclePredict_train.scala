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