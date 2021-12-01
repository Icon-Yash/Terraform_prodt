resource "aws_subnet" "public_subnet" {
  depends_on = [
    aws_vpc.ntiervpc
  ]
  
  vpc_id = aws_vpc.ntiervpc.id
  
  cidr_block = cidrsubnet(var.cidr_block,8,0)
  
  availability_zone = "${var.region}a"
  
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  depends_on = [
    aws_vpc.ntiervpc,
    aws_subnet.public_subnet
  ]
  vpc_id = aws_vpc.ntiervpc.id
  
  cidr_block = cidrsubnet(var.cidr_block,8,1)
  
  availability_zone = "${var.region}b"
  
  tags = {
    Name = "Private Subnet"
  }
}
