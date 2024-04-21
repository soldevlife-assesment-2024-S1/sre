resource "aws_eip" "soldevlife" {
  vpc = true

  tags = {
    Name = "soldevlife"
  }
}

resource "aws_nat_gateway" "soldevlife" {
  allocation_id = aws_eip.soldevlife.id
  subnet_id     = aws_subnet.public_ap_southeast_1a.id

  tags = {
    Name = "soldevlife"
  }

  depends_on = [aws_internet_gateway.soldevlife]
}
