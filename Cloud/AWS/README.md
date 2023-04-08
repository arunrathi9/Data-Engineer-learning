# AWS Cloud Practitioner Essentials

## Lesson 1: Introduction to AWS Cloud Practitioner Essentials

Modules:
  
### Module 1: Introduction to Amazon Web Services
  
  - Summarize the benefits of AWS.
  - Describe differences between on-demand delivery and cloud deployments.
  - Summarize the pay-as-you-go pricing model.
  <l>
  <p>Almost all of modern computing uses a basic client-server model  <br>
    In computing, a client can be a web browser or desktop application that a person interacts with to make requests to computer servers. A server can be services such as Amazon Elastic Compute Cloud (Amazon EC2), a type of virtual server.
    </p>
    
![provision_resources](/Cloud/AWS/image/provision_resources.png)   
 

### Module 2: Compute in the Cloud 
  
  </p>Amazon Elastic Compute Cloud (Amazon EC2) - provides secure, resizable compute capacity in the cloud as Amazon EC2 instances<br>
  
  <b>Amazon EC2 Savings Plans</b> are ideal for workloads that involve a consistent amount of compute usage over a 1-year or 3-year term. <br>
  
  <b>Spot Instances</b> are ideal for workloads with flexible start and end times, or that can withstand interruptions. With Spot Instances, you can reduce your compute costs by up to 90% over On-Demand costs. 

    Unlike Amazon EC2 Savings Plans, Spot Instances do not require contracts or a commitment to a consistent amount of compute usage.
    
  <b>Amazon EC2 instance types</b>
  
  - **General purpose** instances provide a balance of compute, memory, and networking resources.
  - **Compute Optimized** instances are ideal for compute bound applications that benefit from high performance processors.
  - **Memory optimized** instances are more ideal for workloads that process large datasets in memory, such as high-performance databases.
  - **Storage optimized** instances are designed for workloads that require high, sequential read and write access to large datasets on local storage.
  
<p><b>Elastic Load Balancing</b> is the AWS service that automatically distributes incoming application traffic across multiple resources, such as Amazon EC2 instances.</p>
  
  <p><b>Monolithic applications and microservices</b><br>
    Suppose that you have an application with tightly coupled components. These components might include databases, servers, the user interface, business logic, and so on. This type of architecture can be considered a monolithic application.
    <br>
  
  In a microservices approach, application components are loosely coupled. When designing applications on AWS, you can take a microservices approach with services and components that fulfill different functions. Two services facilitate application integration: Amazon Simple Notification Service (Amazon SNS) and Amazon Simple Queue Service (Amazon SQS)
</p>

  <p><b>Amazon Simple Notification Service (Amazon SNS)</b> is a publish/subscribe service. Using Amazon SNS topics, a publisher publishes messages to subscribers. subscribers can be web servers, email addresses, AWS Lambda functions, or several other options. </p>
  
  <p><b>Amazon Simple Queue Service (Amazon SQS)</b> is a message queuing service. You can send, store, and receive messages between software components, without losing messages or requiring other services to be available. In Amazon SQS, an application sends messages into a queue. A user or service retrieves a message from the queue, processes it, and then deletes it from the queue.</p>
  
  <p><b>AWS Lambda</b> is a service that lets you run code without needing to provision or manage servers.
  
<p><b>Amazon Elastic Container Service (Amazon ECS)</b> is a highly scalable, high-performance container management system that enables you to run and scale containerized applications on AWS. 
Amazon ECS supports Docker containers. Docker is a software platform that enables you to build, test, and deploy applications quickly. AWS supports the use of open-source Docker Community Edition and subscription-based Docker Enterprise Edition. With Amazon ECS, you can use API calls to launch and stop Docker-enabled applications.</p>

<p></b>Amazon Elastic Kubernetes Service (Amazon EKS)</b> is a fully managed service that you can use to run Kubernetes on AWS. Kubernetes is open-source software that enables you to deploy and manage containerized applications at scale.</p>

<p><b>AWS Fargate</b> is a serverless compute engine for containers. It works with both Amazon ECS and Amazon EKS.</p>

### Module 3: Global Infrastructure and Reliability

  <p> **AWS Regions**:
  four key factors to choose a Region:
  
  - Compliance
  - Proximity
  - Feature availability
  - Pricing

  **AWS Availability Zone**: A single data center or a group of data centers within a Region. Availability Zones are located tens of miles apart from each other.
  
  **Edge Location**: (nothing but it's name in AWS for CDN(Content Delivery Network) a site that **Amazon CloudFront** uses to store cached copies of your content closer to your customers for faster delivery.
  </p>
  
  **How to provision AWS resources**:
  
  - AWS Management Console (a web based interface)
  - AWS CLI
  - Software Development Kits (SDKs)
  
  **AWS Elastic Beanstalk**:
  you provide code and configuration settings, and Elastic Beanstalk deploys the resources necessary to perform the following tasks:

  - Adjust capacity
  - Load balancing
  - Automatic scaling
  - Application health monitoring
  
  **AWS CloudFormation**:
  you can treat your infrastructure as code. This means that you can build an environment by writing lines of code instead of using the AWS Management Console to individually provision resources.
  
### Module 4: Networking

**Amazon Virtual Private Cloud (Amazon VPC)**:<br>
A networking service that you can use to establish boundaries around your AWS resources.

**Internet gateway**:<br>
To allow public traffic from the internet to access your VPC, you attach an internet gateway to the VPC.
![internet_gateway](/Cloud/AWS/image/internet_gateway.png)

**Virtual private gateway**:<br>
To access private resources in a VPC, you can use a virtual private gateway. It is the component that allows protected internet traffic to enter into the VPC. Even though your connection to the coffee shop has extra protection, traffic jams are possible because you’re using the same road as other customers. A **virtual private gateway** enables you to establish a virtual private network (VPN) connection between your VPC and a private network, such as an on-premises data center or internal corporate network. A virtual private gateway allows traffic into the VPC only if it is coming from an approved network.

**AWS Direct Connect** is a service that enables you to establish a dedicated private connection between your data center and a VPC.
![virtual_private_gateway](/Cloud/AWS/image/virtual_private_gateway.png)

**Subnets and Network Access Control Lists(ACL)**

<img width="877" alt="group" src="https://user-images.githubusercontent.com/27626791/230650221-7b50dfc9-5e2d-48f7-aa68-2c95bb1fda39.png">

- Subnet: 
    a section of a VPC in which you can group resources based on security or operational needs. Subnets can be:
    
    - Public:
        contain resources that need to be accessible by the public, such as an online store’s website.
    - Private:
        contain resources that should be accessible only through your private network, such as a database that contains customers’ personal information and order histories.

  In a VPC, subnets can communicate with each other. eg. a public subnet communicating with databases that are located in a private subnet
  
![network](/Cloud/AWS/image/network.png)

- Network traffic in a VPC
  A <b>packet</b> is a unit of data sent over the internet or a network. The VPC component that checks packet permissions for subnets is a network access control list (ACL).
  - Network Access Control List (ACL): <br> a virtual firewall that controls inbound and outbound traffic at the subnet level.
  
  - Security Group: a virtual firewall that controls inbound and outbound traffic for an Amazon EC2 instance. By default, a security group denies all inbound traffic and allows all outbound traffic. You can add custom rules to configure which traffic to allow or deny.
  
![State](/Cloud/AWS/image/state.png)

  - Stateful: Security groups perform stateful packet filtering. They remember previous decisions made for incoming packets.
  
  - Stateless: Network ACLs perform stateless packet filtering. They remember nothing and check packets that cross the subnet border each way: inbound and outbound.
  
- Global Networking
  Domain Name System(DNS) resolution is the process of translating a domain name to an IP address.
  
  - <b>Amazon Route 53</b> is a DNS web service. It gives developers and businesses a reliable way to route end users to internet applications hosted in AWS. Another feature of Route 53 is the ability to manage the DNS records for domain names. 
  
### Module 5: Storage and Databases

**Instance stores and Amazon Elastic Block Store (Amazon EBS)**

- Instance store: provides temporary block-level storage for an Amazon EC2 instance. It has the same lifespan as the instance. If EC2 instance is deleted/stopped, then instance store also get delete automatically.

- Amazon Elastic Block Store (Amazon EBS): a service that provides block-level storage volumes that you can use with Amazon EC2 instances. If you stop or terminate an Amazon EC2 instance, all the data on the attached EBS volume remains available. EBS snapshot is an incremental backup

- **Amazon Simple Storage Service (Amazon S3)**: a service that provides object-level storage. Amazon S3 stores data as objects in buckets. The maximum file size for an object in Amazon S3 is 5 TB. 
    Amazon S3 different classes/tiers:
      - Standard:
          - Designed for frequently accessed data
          - Stores data in a minimum of three Availability Zones
      - Standard-Infrequent Access (S3 Standard-IA:
          - infrequently accessed data
          - lower storage price and higher retrieval price
      - Glacier Instant Retrieval:
          - well for archived data that requires immediate access.
      - Outposts:
          - delivers object storage to your on-premises AWS Outposts environment.
    
Clash of the Storage classes:<br>
Usage depends on case:

  - If there are not changes need to make into the file, then S3 is a good option.
  - But if changes need to made in the file, then EBS is good as it stores the file as a blocks and can be easily edited.<br>
<img width="752" alt="AWS_EBS" src="https://user-images.githubusercontent.com/27626791/230702595-c5c8079c-476c-4309-b5d1-a2c9bee88255.png">
<img width="751" alt="AWS_S3" src="https://user-images.githubusercontent.com/27626791/230702599-f61a1b0a-196d-4cd6-ae22-0b8af7e7bdf4.png">

**Amazon Elastic File System (Amazon EFS)**:

  <p>In file storage, multiple clients (such as users, applications, servers, and so on) can access data that is stored in shared file folders. In this approach, a storage server uses block storage with a local file system to organize files. Clients access data through file paths.<br>Compared to block storage and object storage, file storage is ideal for use cases in which a large number of services and resources need to access the same data at the same time.</p>
  
  **Amazon Elastic File System (Amazon EFS)** is a scalable file system used with AWS Cloud services and on-premises resources. As you add and remove files, Amazon EFS grows and shrinks automatically. It can scale on demand to petabytes without disrupting applications.<br>
  <img width="253" alt="Ebs" src="https://user-images.githubusercontent.com/27626791/230702955-8ffb1d3b-8340-407b-b617-fb23ee67ba2a.png">
<img width="254" alt="efs" src="https://user-images.githubusercontent.com/27626791/230702959-67feb38c-6c9a-4364-b497-7947efc0e8ae.png">


  **Amazon Relational Database Service (Amazon RDS)**: <br>
    a service that enables you to run relational databases in the AWS Cloud. **Amazon Aurora** is an enterprise-class relational database. It is compatible with MySQL and PostgreSQL relational databases. It is up to **five times faster** than standard MySQL databases and up to **three times faster** than standard PostgreSQL databases. Also, cost is less.


**Amazon DynamoDB**
  
  - Nonrelational databases are sometimes referred to as “NoSQL databases” because they use structures other than rows and columns to organize data.
  - a key-value database service. It delivers single-digit millisecond performance at any scale.
  - serverless, which means that you do not have to provision, patch, or manage servers.


**Amazon Redshift**

  - a data warehousing service that you can use for big data analytics. It offers the ability to collect data from many sources and helps you to understand relationships and trends across your data.

**AWS Database Migration Service (DMS)**

  - enables you to migrate relational databases, nonrelational databases, and other types of data stores.

**Amazon DocumentDB** is a document database service that supports MongoDB workloads. (MongoDB is a document database program.)

**Amazon Neptune** is a graph database service. eg. used for social media

### Module 6: Security

  - **Shared responsibility model**
    - AWS is responsible for some parts of your environment and you (the customer) are responsible for other parts.


  - **User permissions and access**
    - AWS Identity and Access Management (IAM): enables you to manage access to AWS services and resources securely.
    - AWS account root user: think of the root user as being similar to the owner of the coffee shop. It has complete access to all the AWS services and resources in the account.
    - IAM users: An IAM user is an identity that you create in AWS. It represents the person or application that interacts with AWS services and resources. It consists of a name and credentials.
    - IAM policies: An IAM policy is a document that allows or denies permissions to AWS services and resources.
    - IAM groups: An IAM group is a collection of IAM users. When you assign an IAM policy to a group, all users in the group are granted permissions specified by the policy.
    - IAM Roles: An IAM role is an identity that you can assume to gain temporary access to permissions.

  - **AWS Organizations**
    - In AWS Organizations, you can centrally control permissions for the accounts in your organization by using service control policies (SCPs). SCPs enable you to place restrictions on the AWS services, resources, and individual API actions that users and roles in each account can access.
    - In AWS Organizations, you can group accounts into organizational units (OUs) to make it easier to manage accounts with similar business or security requirements.
    - can apply service control policies (SCPs) to the organization root, an individual member account, or an OU.


  - AWS Compliance
    - **AWS Artifact** is a service that provides on-demand access to AWS security and compliance reports and select online agreements. AWS Artifact consists of two main sections:
      - AWS Artifact Agreements
      - AWS Artifact Reports.
