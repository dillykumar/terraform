provider "aws" {
       region = var.aws_region
}

#VPC 
resource "awc_vpc" "terra_vpc" {
     cidr_block  = var.vpc_cidr
     tags = {
         Name = "Terraform_VPC"
     }
}

$Internet Gateway
resource "aws_internet_gateway" "terra_igw" {
    vpc_id = "${aws_vpc.terra_vpc.id}"
    tags = {
        Name = "main"
    }
}

# Subnets : public
resource "aws_subnet" "public" {
    count = "${length(var.subnets_cidr)}"
    vpc_id = "${aws_vpc.terra_vpc.id}"
    cidr_block = "${element(var.subnets_cidr,count.index)}"
    availabiltiy_zone = "${element(var.azs,count.index)}
    tags = {
        Name = "Subnet.${count.index+1}"
    }
}
# Rounte  table : attach internet gateway 
resource "aws_route_table" "public_rt" {
    vpc_id = "${aws_vpc.terra_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.terra_igw.id}"
     }
     tags = {
         Name = "publicRouteTable"
     }
}

# Route table association with public subnets 
resource "aws_route_table_association" "a" {
    count = "${}
}