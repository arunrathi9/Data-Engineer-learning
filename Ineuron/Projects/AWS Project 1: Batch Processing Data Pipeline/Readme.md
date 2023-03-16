# AWS Batch Processing Data Pipeline

**Used AWS Services**
- Lambda
- EventBridge
- S3
- Glue
- DynamoDB
- IAM
- Boto3 (AWS SDK for Python to create, configure, and manage AWS services)


## Project Architecture Design

<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/9daf82488e4857211cf499ed597e18f72a23e814/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/image.jpg" alt= “Project-Architecture-Design” width="70%" height="50%" title="Project Architecture Design">

<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/2916b1f0d520379eaea475ec502b3ab3e1ec2b7c/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/aws-batch-data-pipeline.jpg" alt= “Project-Architecture-Design” width="70%" height="70%" title="Project Architecture Design">

## Method-1: EventBridge Trigger (frequency - every hour)
<p>To Trigger the pipeline at fixed interval as this is a batch dataflow.</p>
<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/892d8fe32869d21c65ccc95fb24fa8512101796f/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/eventbridge.png" alt= “EventBridge” width="70%" height="70%" title="EventBridge">


## Method-2: Mock Data Generator
<p>This Lamdba is used to generator some random data for processing it to Next Lamdba</p>
<p>Code file for this function: <b>mock-data-generator-lambda.py</b></p>
<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/0e5be75d38459e122020befbcb9deef7319f553d/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/mock-data-generator.png" alt= “Mock-Data-Generator” width="70%" height="70%" title="Mock Data Generator">

## Method-3: Writing Data to S3 storage
<p>This Lamdba is used to get the response from method-1 and write the json string to S3</p>
<p>Code file for this function: <b>write-data-to-s3.py</b></p>
<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/8830c3c15fd76030403f7336b074177f03fd831e/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/write-data-to-s3.png" alt= “write-data-to-s3” width="70%" height="70%" title="write-data-to-s3">

## Method-4: Creating S3 Storage
<p>S3 storage created to store the data</p>
<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/d40500f5ec0cee7d7d3f037a5c381441bb7702ca/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/buckets.png" alt= “S3-Bucket” width="70%" height="70%" title="S3 Bucket">

## Method-5: AWS Glue Job
<p>ETL jobs to ingest the data to DynamoDB</p>
<p>Code file for this function: <b>data-ingestion-to-dynamodb.py</b></p>
<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/fc5542b37c4f0404411eff9621808796bcba9012/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/ingestion.png" alt= “AWS-Glue” width="70%" height="70%" title="AWS Glue">

## Method-6: Dynamo DB
<p>Data Ingestion to AWS key-value NoSQL database (DynamoDB)</p>
<img src="https://github.com/arunrathi9/Data-Engineer-learning/blob/8abcfcc6c523f02e9ed5beac2aeb4fa643791f17/Ineuron/Projects/AWS%20Project%201:%20Batch%20Processing%20Data%20Pipeline/dynamodb.png" alt= “DynamoDB” width="70%" height="70%" title="Dynamo DB">

Thanks for checking.
