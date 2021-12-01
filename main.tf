resource "aws_vpc" "ntiervpc" {

  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  
  tags = {
    Name = "ntiervpc"
  }
}

resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.ntiervpc,
    aws_subnet.public_subnet,
    aws_subnet.private_subnet
  ]
  
  
  vpc_id = aws_vpc.ntiervpc.id

  tags = {
    Name = "ntierigw"
  }
}


resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.RT-IG-Association
  ]
  vpc = true
}


resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

 
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "ntierngw"
  }
}
/*
resource "aws_s3_bucket" "s3bucket" {

    bucket = var.mybucket
    acl = var.acl

    versioning {
      enabled =true
    }
    
    tags = {
      "Name" = "my_bucket"      
    }  
}*/

resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.ntiervpc.id
  service_name = "com.amazonaws.${var.region}.s3"

 tags={
   Environment = "test"
 }  
}