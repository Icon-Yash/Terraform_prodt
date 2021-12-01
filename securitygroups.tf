resource "aws_security_group" "websg" {
  depends_on = [
    aws_vpc.ntiervpc,
    aws_subnet.public_subnet,
    aws_subnet.private_subnet
  ]

  description = "HTTP, PING, SSH"

  
  name = "websg"
  

  vpc_id = aws_vpc.ntiervpc.id

  ingress {
    description = "port http"
    from_port   = local.http
    to_port     = local.http

    protocol    = local.tcp
    cidr_blocks = [local.anywhere]
  }


  ingress {
    description = "ping"
    from_port   = local.ping
    to_port     = local.ping
    protocol    = local.icmp
    cidr_blocks = [local.anywhere]
  }

  
  ingress {
    description = "port 22"
    from_port   = local.ssh
    to_port     = local.ssh
    protocol    = local.tcp
    cidr_blocks = [local.anywhere]
  }

  /*
  egress {
    description = "output from webserver"
    from_port   = local.ping
    to_port     = local.ping
    protocol    = "-1"
    cidr_blocks = [local.anywhere]
  }*/
}