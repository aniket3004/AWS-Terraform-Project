# Create the VPC

resource "aws_vpc" "app_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(var.common_tags, {
    Name : "${var.naming_prefix}-vpc"
  })
}


# Create the Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = merge(var.common_tags, {
    Name : "${var.naming_prefix}-igw"
  })
}

# Create the public subnets

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.app_vpc.id

  count             = length(var.vpc_public_subnets_cidr_block)
  cidr_block        = element(var.vpc_public_subnets_cidr_block, count.index)
  availability_zone = element(var.aws_azs, count.index)

  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    Name : "${var.naming_prefix}-pubsubnet-${count.index + 1}"
  })
}


# Create the route table

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.common_tags, {
    Name : "${var.naming_prefix}-rtable"
  })
}


# Assign the public route table to the public subnet

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(var.vpc_public_subnets_cidr_block)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}


# Create the security group for EC2

resource "aws_security_group" "sg" {
  description = "Allow outgoing traffic for EC2"
  vpc_id      = aws_vpc.app_vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.common_tags, {
    Name : "${var.naming_prefix}-sg-ec2"
  })
}

# Define the security group for the LB

resource "aws_security_group" "alb-sg" {
  description = "Allow incoming connections for load balancer"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg.id]
    description     = "Allow outgoing traffic to EC2"
  }

  tags = merge(var.common_tags, {
    Name : "${var.naming_prefix}-sg-lb"
  })
}


# Add an inbound rule to EC2 security group to allow traffic from ALB security group

resource "aws_security_group_rule" "name" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg.id
  source_security_group_id = aws_security_group.alb-sg.id
}

