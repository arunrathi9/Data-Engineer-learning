# Databricks Academy: Advanced Data Engineering with Databricks

## Module 1: Incremental processing with Spark structured streaming

### SubMod 1: Streaming Data Concepts

Streaming data - continuously generated and unbounded (infinite) data. <br>
  &emsp;  Typical data sources - clickstreams, application events, mobile & iot data


![img1](images/m1-proc.png)

![img2](images/m1-strm.png)

![img3](images/m1-uc.png)

![img4](images/m1-unData.png)

![img4](images/m1-adv.png)

![img4](images/m1-chall.png)


### SubMod 2: Introduction to Structured streaming

![img4](images/m1-ss.png)

![img4](images/m1-ssw.png)

![img4](images/m1-ssw2.png)

**Anatomy of Streaming Query** <br>
df = spark.readStream.format("kafka")<br>.option("kafka.bootstrap.servers","....")<br>.option("subscribe","topicName")<br>.load()

**to transform the data after read. eg reading nested json**
![img4](images/m1-selectExpr.png)

**to write the streaming data to a defined path**
![img4](images/m1-write.png)

**to define the trigger as per requirement apart from default configs**
![img4](images/m1-trigger.png)

**different types of triggers**
![img4](images/m1-ttypes.png)

**output mode to write to sink**
![img4](images/m1-ot.png)

![img4](images/m1-otm.png)

**Benefits of Structured Streaming**
![img4](images/m1-benef.png)

![img4](images/m1-benef2.png)

**Structured Streaming with Delta Lake**
![img4](images/m1-dl.png)

![img4](images/m1-dl2.png)

![img4](images/m1-dl3.png)

**Demo 1: Streaming**
![img4](images/m1-lab1.png)
![img4](images/m1-lab2.png)
![img4](images/m1-lab3.png)
![img4](images/m1-lab4.png)
![img4](images/m1-lab5.png)
![img4](images/m1-lab6.png)
![img4](images/m1-lab7.png)
![img4](images/m1-lab8.png)

**Aggregate, Time windows, & Watermarking**
![img4](images/m1-sp1.png)
![img4](images/m1-sp2.png)
![img4](images/m1-sp3.png)
![img4](images/m1-sp4.png)
![img4](images/m1-sp5.png)
![img4](images/m1-sp6.png)

## Module 2: Streaming ELT patterns with DLT

![img4](images/m1-pt1.png)
![img4](images/m1-pt2.png)
![img4](images/m1-pt3.png)
![img4](images/m1-pt4.png)
![img4](images/m1-pt5.png)

**Demo: Auto Loader**
![img4](images/m1-auto1.png)
![img4](images/m1-auto2.png)
![img4](images/m1-auto3.png)
![img4](images/m1-auto4.png)
![img4](images/m1-auto5.png)
![img4](images/m1-auto6.png)
![img4](images/m1-auto7.png)

**Demo 2: Streaming from Multiplex bronze**
![img4](images/m1-plex1.png)
![img4](images/m1-plex2.png)
![img4](images/m1-plex3.png)
![img4](images/m1-plex4.png)

**Data Quality enforcement patterns**
![img4](images/m1-qq1.png)
![img4](images/m1-qq2.png)
![img4](images/m1-qq3.png)

![img4](images/m1-qq4.png)

**Data Modelling**
Slowing changing dimensions in Lakehouse
<br>

![img4](images/m1-tt1.png)
![img4](images/m1-tt2.png)

![img4](images/m1-tt3.png)
![img4](images/m1-tt4.png)
![img4](images/m1-tt5.png)

**Demo: SCD**
![img4](images/m1-scd1.png)
![img4](images/m1-scd2.png)
![img4](images/m1-scd3.png)
![img4](images/m1-scd4.png)
![img4](images/m1-scd5.png)

**Streaming joins and Statefulness**
![img4](images/m1-state1.png)
![img4](images/m1-state2.png)
![img4](images/m1-state3.png)

**Demo: Streaming static jobs**
![img4](images/m1-join1.png)
![img4](images/m1-join2.png)
![img4](images/m1-join3.png)
![img4](images/m1-join4.png)
![img4](images/m1-join5.png)
![img4](images/m1-join6.png)
![img4](images/m1-join7.png)


## Module 3: Data security and goverance patterns

**secure data**
![img4](images/m1-secure1.png)
![img4](images/m1-secure2.png)
![img4](images/m1-secure3.png)
![img4](images/m1-secure4.png)
![img4](images/m1-secure5.png)
![img4](images/m1-secure6.png)
![img4](images/m1-secure7.png)
![img4](images/m1-secure8.png)
![img4](images/m1-secure9.png)
![img4](images/m1-secure10.png)
![img4](images/m1-secure11.png)
![img4](images/m1-secure12.png)

**Demo: PII lookup table**
![img4](images/m1-tab1.png)
![img4](images/m1-tab2.png)
![img4](images/m1-tab3.png)
![img4](images/m1-tab4.png)

**Demo: Pseudonymized ETL**
![img4](images/m1-etl1.png)
![img4](images/m1-etl2.png)
![img4](images/m1-etl3.png)
![img4](images/m1-etl4.png)
![img4](images/m1-etl5.png)

**Streaming data and CDF**
![img4](images/m1-cdf1.png)
![img4](images/m1-cdf2.png)
![img4](images/m1-cdf3.png)

## Module 4: Optimization performance with Spark and Delta Lake

**Designing the foundation**
![img4](images/m4-fun1.png)
![img4](images/m4-fun2.png)
![img4](images/m4-fun3.png)
![img4](images/m4-fun4.png)
![img4](images/m4-fun5.png)
![img4](images/m4-fun6.png)
![img4](images/m4-fun7.png)

**Code Optimization**
![img4](images/m4-op1.png)
![img4](images/m4-op2.png)

**Assess and Debug Spark Applications**
![img4](images/m4-qq.png)

![img4](images/m4-ui.png)

**Shuffles**
![img4](images/m1-shuf1.png)
![img4](images/m1-shuf2.png)
![img4](images/m1-shuf3.png)
![img4](images/m1-shuf4.png)
![img4](images/m1-shuf5.png)
![img4](images/m1-shuf6.png)

**Spill**
![img4](images/m1-spill1.png)
![img4](images/m1-spill2.png)
![img4](images/m1-spill3.png)
![img4](images/m1-spill4.png)

**Skew**
![img4](images/m1-skew1.png)
![img4](images/m1-skew2.png)
![img4](images/m1-skew3.png)

**Serialization**
![img4](images/m4-serial1.png)
![img4](images/m4-serial2.png)

**Choosing right cluster**
![img4](images/m4-cluster1.png)
![img4](images/m4-cluster2.png)
![img4](images/m4-cluster3.png)
![img4](images/m4-cluster4.png)
![img4](images/m4-cluster5.png)
![img4](images/m4-cluster6.png)
![img4](images/m4-cluster7.png)

## Module 6: Automate production workflows

**REST API and CLI**


**working with terraform**
