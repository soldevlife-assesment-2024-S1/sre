resource "aws_subnet" "private_ap_southeast_1a" {
  vpc_id            = aws_vpc.soldevlife.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "ap-southeast-1a"

  tags = {
    "Name"                             = "private_ap_southeast_1a"
    "kubernetes.io/cluster/soldevlife" = "shared"
    "kubernetes.io/role/internal-elb"  = "1"
  }

}

resource "aws_subnet" "private_ap_southeast_1b" {
  vpc_id            = aws_vpc.soldevlife.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "ap-southeast-1b"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address

  map_public_ip_on_launch = true

  tags = {
    "Name"                             = "private_ap_southeast_1b"
    "kubernetes.io/cluster/soldevlife" = "shared"
    "kubernetes.io/role/internal-elb"  = "1"
  }

}


resource "aws_subnet" "public_ap_southeast_1a" {
  vpc_id                          = aws_vpc.soldevlife.id
  cidr_block                      = "10.0.64.0/19"
  availability_zone               = "ap-southeast-1a"

  tags = {
    "Name"                             = "public_ap_southeast_1a"
    "kubernetes.io/cluster/soldevlife" = "owned"
    "kubernetes.io/role/elb"           = "1"
  }
}


resource "aws_subnet" "public_ap_southeast_1b" {
  vpc_id                          = aws_vpc.soldevlife.id
  cidr_block                      = "10.0.96.0/19"
  availability_zone               = "ap-southeast-1b"

  tags = {
    "Name"                             = "public_ap_southeast_1b"
    "kubernetes.io/cluster/soldevlife" = "owned"
    "kubernetes.io/role/elb"           = "1"
  }
}
