provider "aws" {
    region = "ap-south-1"
}

resource "aws_key_pair" "demo_key" {
    key_name   = "manju-aws-demo-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "demo-server" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    key_name = "manju-aws-demo-key"
    vpc_security_group_ids = ["sg-343222"]
    subnet_id = "subnet-eddcddzz3"
    associate_public_ip_address = false

    tags = {
    name = "demo-server"
    evn = "dev"
    project="demo"
}
}

resource "aws_eip" "demo_eip" {
    instance = aws_instance.demo-server.id
}

resource "aws_security_group" "demo-serversg" {
    name ="demo-sg"
    description = "Allow the required port"
    vpc_id = "vpc-0e8029999a9ss9333"

  ingress {
    description = "allow http"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    description = 80
    from_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
 }

 ingress {
    description = 22
    fromfrom_port = 22
    protocol = "tcp"
    cidr_blocks = [ "106.51.92.90/32" ]
 }

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}


  
}

output "instance_public_ip" {
    description = "Public IP of the created Ec2 instance"
    value = aws_instance.demo-server.public_ip
}

output "instance_id" {
    description = "Instance IP of the created Ec2 instance"
    value = aws_instance.demo-server.id
}

output "elastic_ip" {
    description = "Elastic IP Address of the EC2 instance"
    value       = aws_eip.demo_eip.public_ip
}


resource "aws_s3_bucket" "demo-bucket" {
    bucket = "demo-bucket-870"
    acl    = "private"
    tags = {
        name = "demo-s3-bucket"
        evn = "demo"
    }
    #versioning enabled
    versioning {
      enabled = true
    }
}

output "s3_bucket_name" {
    description = "S3 Bucket Name"
    value       = aws_s3_bucket.demo-bucket.id
}

output "s3_bucket_arn" {
    description = "S3 Bucket ARN"
    value       = aws_s3_bucket.demo-bucket.arn
}



