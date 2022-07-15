
resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "allow ssh"
  vpc_id      = aws_vpc.terraform-vpc.id
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

// second security group
resource "aws_security_group" "allow-22-3000" {
  name        = "allow-22-3000"
  description = "allow port 22 and 3000"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  ingress {
    description      = "3000"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_22_3000"
  }
}