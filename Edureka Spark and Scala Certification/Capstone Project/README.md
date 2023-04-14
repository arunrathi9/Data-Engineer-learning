# Edureka: Apache Spark And Scala Capstone Project

## Project Name - Bicycle Sharing Demand (Domain: Transportation Industry)

### Business Challenge/requirement

<p>
</p>

### Project code

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

