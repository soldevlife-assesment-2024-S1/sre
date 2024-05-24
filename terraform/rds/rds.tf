variable "identifier" {
  description = "Identifier for the DB instance"
  type        = string
  default     = "ticket-service-db"
}

variable "tags_name" {
  description = "Name tag for the DB instance"
  type        = string
  default     = "ticket-service-db"
}

resource "aws_db_subnet_group" "soldevlife_db" {
  name       = "soldevlife-db-subnet-group"
  subnet_ids = [aws_subnet.private_ap_southeast_1a.id, aws_subnet.private_ap_southeast_1b.id]

}

resource "aws_security_group" "soldevlife_db" {
  name        = "soldevlife-db"
  description = "Allow inbound traffic on port 5432"
  vpc_id      = aws_vpc.soldevlife.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "soldevlife_db" {
  identifier             = var.identifier
  engine                 = "postgres"
  engine_version         = "16.2"
  instance_class         = "db.t2.medium"
  allocated_storage      = 30
  storage_type           = "gp2"
  storage_encrypted      = false
  username               = "postgres"
  password               = "P@ssw0rd"
  port                   = 5432
  db_subnet_group_name   = aws_db_subnet_group.ticket-service-db-subnet-group.name
  vpc_security_group_ids = ["default", aws_security_group.soldevlife_db.id]
  parameter_group_name   = "soldevlife"
  skip_final_snapshot    = true
  publicly_accessible    = false
  tags = {
    Name = var.tags_name
    App  = "soldevlife"
  }
}
