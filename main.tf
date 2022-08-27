provider "aws" {
  region = "us-west-2"
}

# Query all avilable Availibility Zone
data "aws_availability_zones" "available" {}

# VPC Creation

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true   #enabling hostname
  enable_dns_support   = true

  tags = {
    Name = "my-new-test-terraform-vpc"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "my-test-igw"
  }
}
# Public Route Table

resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "my-test-public-route"
  }
}
