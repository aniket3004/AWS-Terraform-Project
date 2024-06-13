# Get latest Amazon Linux 2 AMI

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# Create the EC2 Web Server

resource "aws_instance" "web" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.instance_type
  key_name        = var.instance_key
  security_groups = var.security_group_ec2

  count     = length(var.public_subnets)
  subnet_id = element(var.public_subnets, count.index)

  user_data = <<-EOF
    #!bin/bash
    #install httpd
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF

  tags = merge(var.common_tags, {
    Name : "${var.naming_prefix}-ec2-${count.index + 1}"
  })
}