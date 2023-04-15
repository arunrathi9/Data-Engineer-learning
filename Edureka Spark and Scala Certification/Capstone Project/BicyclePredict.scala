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
predictions.write.format("jdbc").option("url", "jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal/arunrathit38edu").option("driver", "com.mysql.cj.jdbc.Driver").option("dbtable", "predictions").option("user", "arunrathit38edu").option("password", "").mode(SaveMode.Append).save
}
}
ssc.start()
ssc.awaitTermination()
}
}