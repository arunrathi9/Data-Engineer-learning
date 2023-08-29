# Project 4: MySQL - Kaka - S3 - Redshift

## About the Project
<p> Working on this Project to understand
Learning Technologies:

- MySQL
- KAFKA
- AWS S3
- REDSHIFT

Please follow the below steps to complete this Project
</p>

## Step 1: Creating the IAM role in AWS to generate access keys
<p> In this step, we will create the IAM role to interact with AWS Redshift

- Go to IAM, then select Users
- Create a new User
    - Select Attach policies directly (policy - AdministratorAccess), then next
- Go to Security Credentials on created user and create the Access Key
- Download the CSV
- Open terminal and hit the below command:
    - export AWS_ACCESS_KEY_ID="put the value from CSV"
    - export AWS_SECRET_ACCESS_KEY="put the value from CSV"

</p>

## Step 2: Docker-compose file execution
<p> command - docker compose -f docker-compose.yml up -d