# Terraform AWS Highly Available Web Server Project

This project automates the deployment of a highly available web server infrastructure on AWS using Terraform. The infrastructure includes multiple web servers deployed across different availability zones (AZs), load balancers for distributing traffic, and necessary networking components.

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Prerequisites](#prerequisites)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Configuration](#configuration)
7. [Customization](#customization)
8. [Contributing](#contributing)
9. [Running Website](#running-website)


## Overview

This project aims to provide a scalable and fault-tolerant web server setup on AWS using Terraform. It leverages AWS's capabilities such as Elastic Load Balancers (ELB), and Virtual Private Clouds (VPC) to achieve high availability and reliability for web applications.

## Architecture

The architecture deployed by Terraform includes the following components:
- Multiple EC2 instances spread across different AZs.
- Application Load Balancer (ALB) to distribute incoming traffic across the EC2 instances.
- Virtual Private Cloud (VPC) with public and private subnets.
- Security Groups to control traffic to EC2 instances and ALB.

For a detailed view, refer to the Terraform configuration files (`*.tf`) in this repository.

## Prerequisites

Before you begin, ensure you have the following:
- AWS account with appropriate permissions to create resources.
- Terraform installed locally. You can download it from [terraform.io](https://www.terraform.io/downloads.html).

## Installation

To deploy the infrastructure using Terraform:
1. Clone this repository:
   ```
   git clone https://github.com/aniket3004/AWS-Terraform-Project.git
   cd repository
   
2. Initialize Terraform:
   ```
   terraform init
   
3. Review and customize the `variables.tf` file to set necessary configurations.
4. Apply the Terraform configuration:
   ```
   terraform apply
   

## Usage

After deployment, you can access your web application via the ALB's DNS name. To manage the infrastructure:
- Use `terraform plan` to see the execution plan.
- Use `terraform apply` to apply the changes required to reach the desired state of the configuration.
- Use `terraform destroy` to destroy the Terraform-managed infrastructure.

## Configuration

The `variables.tf` file contains configurable variables such as instance type, AMI ID, and AWS region. Adjust these variables as per your requirements before applying the Terraform configuration.

## Customization

You can customize the Terraform modules and configurations to suit specific needs:
- Add more AWS resources such as databases or caching layers.
- Incorporate security best practices or additional monitoring.


## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes. For major modifications, please open an issue first to discuss the proposed changes.


## Running Website:

![Alt text](/images/vm1.png)

![Alt text](/images/vm2.png)

VPC:
![Alt text](/images/vpc.png)

EC2:
![Alt text](/images/ec2.png)

ALB:
![Alt text](/images/alb.png)

---

Feel free to expand or customize this template further based on specific details of your project and the complexity of your Terraform configuration. This README file serves as a starting point to guide users and contributors through your AWS Terraform project effectively.