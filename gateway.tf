resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "main-gw"
  }
}