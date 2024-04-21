resource "aws_internet_gateway" "soldevlife" {
  vpc_id = aws_vpc.soldevlife.id

  tags = {
    Name = "soldevlife"
  }
}
