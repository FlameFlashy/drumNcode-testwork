resource "aws_vpc" "drumncode_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    name = "drumncode_vpc"
  }
}

resource "aws_subnet" "drumncode_vpc" {
  count                   = 2
  vpc_id                  = aws_vpc.drumncode_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.drumncode_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(["eu-central-1a", "eu-central-1b"], count.index)
}

resource "aws_internet_gateway" "drumncode_vpc" {
  vpc_id = aws_vpc.drumncode_vpc.id
}

resource "aws_route_table" "drumncode_vpc" {
  vpc_id = aws_vpc.drumncode_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.drumncode_vpc.id
  }
}

resource "aws_route_table_association" "drumncode_vpc" {
  count          = 2
  subnet_id      = aws_subnet.drumncode_vpc[count.index].id
  route_table_id = aws_route_table.drumncode_vpc.id
}