resource "aws_route_table" "Public-Subnet-RT" {
  depends_on = [
    aws_vpc.ntiervpc,
    aws_internet_gateway.Internet_Gateway
  ]

   
  vpc_id = aws_vpc.ntiervpc.id

 
  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "Route Table for Internet Gateway"
  }
}

resource "aws_route_table_association" "RT-IG-Association" {

  depends_on = [
    aws_vpc.ntiervpc,
    aws_subnet.public_subnet,
    aws_subnet.private_subnet,
    aws_route_table.Public-Subnet-RT
  ]


  subnet_id      = aws_subnet.public_subnet.id

  route_table_id = aws_route_table.Public-Subnet-RT.id
}
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.ntiervpc.id

  route {
    cidr_block = local.anywhere
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}

resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]


  subnet_id      = aws_subnet.private_subnet.id


  route_table_id = aws_route_table.NAT-Gateway-RT.id
}