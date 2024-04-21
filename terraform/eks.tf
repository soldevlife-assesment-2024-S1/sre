resource "aws_iam_role" "eks_cluster_soldevlife" {
  name               = "eks_cluster_soldevlife"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_soldevlife_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_soldevlife.name
}

resource "aws_eks_cluster" "soldevlife" {
  name     = "soldevlife"
  role_arn = aws_iam_role.eks_cluster_soldevlife.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids = [
      aws_subnet.private_ap_southeast_1a.id,
      aws_subnet.private_ap_southeast_1b.id,
      aws_subnet.public_ap_southeast_1a.id,
      aws_subnet.public_ap_southeast_1b.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_soldevlife_AmazonEKSClusterPolicy
  ]
}
