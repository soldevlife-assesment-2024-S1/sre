resource "aws_route_table" "private_soldevlife" {
  vpc_id = aws_vpc.soldevlife.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.soldevlife.id
  }
  tags = {
    Name = "private_soldevlife"
  }
}

resource "aws_route_table" "public_soldevlife" {
  vpc_id = aws_vpc.soldevlife.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.soldevlife.id
  }
  tags = {
    Name = "public_soldevlife"
  }
}

resource "aws_route_table_association" "private_ap_southeast_1a_soldevlife" {
  subnet_id      = aws_subnet.private_ap_southeast_1a.id
  route_table_id = aws_route_table.private_soldevlife.id
}

resource "aws_route_table_association" "private_ap_southeast_1b_soldevlife" {
  subnet_id      = aws_subnet.private_ap_southeast_1b.id
  route_table_id = aws_route_table.private_soldevlife.id
}

resource "aws_route_table_association" "public_ap_southeast_1a_soldevlife" {
  subnet_id      = aws_subnet.public_ap_southeast_1a.id
  route_table_id = aws_route_table.public_soldevlife.id
}

resource "aws_route_table_association" "public_ap_southeast_1b_soldevlife" {
  subnet_id      = aws_subnet.public_ap_southeast_1b.id
  route_table_id = aws_route_table.public_soldevlife.id
}



