# Web Tier using AWS EC2 Linux (Multi-AZ with ALB)

Deploying Linux Server EC2 Instances in AWS using Terraform with ALB and Multi AZ


1. vpc module - to create vpc, public subnets, internet gateway, security groups and route tables
2. web module - to create Linux Web EC2 instances with userdata script to display instance metadata using latest Amazon Linux ami in multiple subnets created in vpc module
3. alb module - to create an application load balancer with target group containing ec2 instances from web module
4. main module - Above modules get called in main config.



Outputs:

alb_dns_name = "tf-lb-20240611143924238100000005-416065247.us-east-1.elb.amazonaws.com"
ec2_instance_ids = [
  "i-05ddf8b19ef0e93a8",
  "i-0e588e5aed510a9b0",
]
public_subnets = [
  "subnet-0f9a964167fd83d02",
  "subnet-08441f9cdc174869c",
]
security_group_alb = [
  "sg-09c07402808ca70f4",
]
security_group_ec2 = [
  "sg-0d2ce718dc8bdeff8",
]

Running Website:

![Alt text](/images/vm1.png)

![Alt text](/images/vm2.png)

VPC:
![Alt text](/images/vpc.png)

EC2:
![Alt text](/images/ec2.png)

ALB:
![Alt text](/images/alb.png)