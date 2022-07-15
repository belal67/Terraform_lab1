resource "aws_route_table" "public-rt1" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
    
  }

  tags = {
    Name = "publicroute1"
  }
}

resource "aws_route_table" "private-rt1" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
    
  }

  tags = {
    Name = "privateroute1"
  }
}