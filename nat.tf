resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.private1.id

  tags = {
    Name = "NAT gw"
  }
}