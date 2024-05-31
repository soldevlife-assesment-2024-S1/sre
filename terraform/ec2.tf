resource "tls_private_key" "terrafrom_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name = "aws_keys_pairs"
  # Public Key: The public will be generated using the reference of tls_private_key.terrafrom_generated_private_key
  public_key = tls_private_key.terrafrom_generated_private_key.public_key_openssh

  # Store private key :  Generate and save private key(aws_keys_pairs.pem) in current directory
  provisioner "local-exec" {
    command = <<-EOT
       echo '${tls_private_key.terrafrom_generated_private_key.private_key_pem}' > aws_keys_pairs.pem
       chmod 400 aws_keys_pairs.pem
     EOT
  }
}


resource "aws_instance" "soldevlife-observability" {
  ami           = "ami-03caf91bb3d81b843"
  instance_type = "t2.medium"
  key_name      = "aws_keys_pairs"

  subnet_id                   = aws_subnet.public_ap_southeast_1a.id
  vpc_security_group_ids      = [aws_security_group.soldevlife.id]
  associate_public_ip_address = true
  tags = {
    Name = "soldevlife-observability"
  }

}
