provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "demo-server" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    key_name = "manju-aws-demo-key"

    tags = {
    name = "demo-server"
    evn = "dev"
    project="demo"
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
