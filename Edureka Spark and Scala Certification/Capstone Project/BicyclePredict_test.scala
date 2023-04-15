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
predictions.write.format("jdbc").option("url", "jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal/arunrathit38edu").option("driver", "com.mysql.cj.jdbc.Driver").option("dbtable", "predictions").option("user", "arunrathit38edu").option("password", "").mode(SaveMode.Append).save }}