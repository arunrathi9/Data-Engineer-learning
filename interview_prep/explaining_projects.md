DE Projects I worked on till now

# Table of content:
- [Cargo](#cargo)

<a id="item-one"></a>
# Project 1: Cargo

## Overview:
I worked most recently on a data engineering project that aims to process the Cargo flight data and make it available for business users. Then, Business users use this data to generate the reports and insights to optimize their revenue and operations. Here, we are processing the data in batch mostly at every hour.

## Problem or Challenge:
One of the key challenges we faced was the increasing volume of data coming in from Accelya (3rd party vendor - use their platform to order and self-service offers). Cost of storing this data on our existing on-prem datacentre was increasing with this, resulting in less profit. Hence, Business decided to move to cloud where we can pay only for the data stored.

## Technologies and Tools Used:
To tackle this issue, we implemented Apache Spark for parallel processing and used Az datalake storage for scalable storage. We also employed Az Data Factory for orchestration of data workflow.

## My Role and contributions:
As the data engineer on this project, I was responsable to build Az data factory pipelines for data orchestration and Databricks for data processing and transformation large quantities of data. We followed Delta architecture for refining data stage wise.

Why we used Delta architecture over lambda:
- Delta arch. is like having a high-powered, adaptable processing engine that can handle different types of data loads seamlessly. It is more simple, consistency (follow acid properties), efficiency (parallel running jobs), flexibility (can be used for one or both batch or real-time processing).

## Challenges Faced:
- We did face a challenge with full write operations then we use the incremental data write approach and it reduces the processing time.

## Emphasize Collaboration Efforts:
- This project was a collaborative effort involving cross-functional teams, including business analysts, data engineers and azure platform team. Clear communication and agile methodologies were crucial in ensuring on-time project deliveries.

## Learnings and Future Steps:
- This project taught me the good knowledge of databricks notebook and metadata storage, integration of azure services like adf, adls and databricks. Also, it taught me the importance of scalability and robustness in data pipelines. Moving forward, we're exploring the make this system more robust as we are getting multiple issue in the system. Mainly, focusing on optimizing the processing time and monitoring to get the update in case of any failure.


**For self references**

