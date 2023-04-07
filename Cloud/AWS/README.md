# AWS Cloud Practitioner Essentials

## Lesson 1: Introduction to AWS Cloud Practitioner Essentials
<p>
Modules:
  
### Module 1: Introduction to Amazon Web Services
  
  - Summarize the benefits of AWS.
  - Describe differences between on-demand delivery and cloud deployments.
  - Summarize the pay-as-you-go pricing model.
  <l>
  <p>Almost all of modern computing uses a basic client-server model  <br>
    In computing, a client can be a web browser or desktop application that a person interacts with to make requests to computer servers. A server can be services such as Amazon Elastic Compute Cloud (Amazon EC2), a type of virtual server.
    </p>  
    
  
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

