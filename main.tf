variable "AK" {
  type = string
}

variable "SK" {
  type = string
}
provider "aws" {
  access_key = var.AK
  secret_key = var.SK
  region = "ap-south-1"

}
resource "aws_security_group" "worker_node_sg" {
  name = "Allow all traffic to worker Nodes"
  tags = {
    Name = "WorkerNodes_AllowAllTraffic"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "worker_nodes" {
  ami             = "ami-0f2ce9ce760bd7133"
  instance_type   = "t2.micro"
  count           = 2
  security_groups = [aws_security_group.worker_node_sg.name]
  key_name = "windows"
  user_data = file("./userdata.sh")
  tags = {
    Name = "Worker nodes"
  }
}

output "node_1_privateIP" {
  value = aws_instance.worker_nodes[0].private_ip
}
output "node_2_privateIP" {
  value = aws_instance.worker_nodes[1].private_ip
}
