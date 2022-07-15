# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Create the Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = "linux-key-pair"  
  public_key = tls_private_key.key_pair.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.key_pair.private_key_pem
}


# Get latest Ubuntu Linux Focal Fossa 20.04 AMI
data "aws_ami" "ubuntu-linux-2004" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create EC2 Instance
resource "aws_instance" "linux-server" {
  ami                         = data.aws_ami.ubuntu-linux-2004.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private1.id
  vpc_security_group_ids = [aws_security_group.allow-22-3000.id]
  key_name                    = aws_key_pair.key_pair.key_name
  user_data                   = file("aws-user-data.sh")
  
  # # root disk
  # root_block_device {
  #   volume_size           = var.linux_root_volume_size
  #   volume_type           = var.linux_root_volume_type
  #   delete_on_termination = true
  # }
  # # extra disk
  # ebs_block_device {
  #   device_name           = "/dev/xvda"
  #   volume_size           = var.linux_data_volume_size
  #   volume_type           = var.linux_data_volume_type
  #   delete_on_termination = true
  # }
  
  tags = {
    Name = "linux-vm"
  }
}


// basion Ec2
resource "aws_instance" "bastionhost" {
  ami                         = data.aws_ami.ubuntu-linux-2004.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]


  tags = {
    Name = "bastionServer"
  }
}
