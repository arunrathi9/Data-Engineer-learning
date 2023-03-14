import json
import boto3
import json
import datetime


def lambda_handler(event, context):
    print(event)
    employee_data = event['responsePayload']
    s3 = boto3.resource('s3')
    BUCKET_NAME = "employee-project-data"
    current_epoch_time = datetime.datetime.now().timestamp()
    
    print("Start Data write in S3")
    s3object = s3.Object(BUCKET_NAME, f"inbox/{str(current_epoch_time}_employee_data.json")
    s3object.put(Body=(bytes(json.dumps(employee_data).encode('UTF-8')))
    print("Successfully write the data in S3")
    # TODO implement
    # return {
    #     'statusCode': 200,
    #     'body': json.dumps('Hello from Lambda!')
    # }
