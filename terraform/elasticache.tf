resource "aws_elasticache_subnet_group" "soldevlife" {
  name       = "soldevlife"
  subnet_ids = [aws_subnet.private_ap_southeast_1a.id, aws_subnet.private_ap_southeast_1b.id]
}

resource "aws_elasticache_cluster" "soldevlife" {
  cluster_id           = "soldevlife"
  engine               = "redis"
  node_type            = "cache.r6g.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.soldevlife.name
  security_group_ids   = [aws_security_group.soldevlife.id]

  tags = {
    App = "soldevlife"
  }
}
