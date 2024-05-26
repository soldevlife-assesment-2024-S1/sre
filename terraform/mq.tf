resource "aws_mq_broker" "soldevlife" {
  broker_name         = "soldevlife"
  engine_type         = "RabbitMQ"
  engine_version      = "3.12.13"
  host_instance_type  = "mq.m5.large"
  publicly_accessible = true
  deployment_mode     = "SINGLE_INSTANCE"
  subnet_ids          = [aws_subnet.private_ap_southeast_1a.id, aws_subnet.private_ap_southeast_1b.id]
  security_groups     = [aws_security_group.soldevlife.id]
  tags = {
    App = "soldevlife"
  }

  user {
    username = "example_user"
    password = "example_password"
  }
}
