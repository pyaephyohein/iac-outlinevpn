resource "aws_lightsail_instance" "outline_instance" {
  name              = "${var.name}-outline"
  availability_zone = var.az
  blueprint_id      = "ubuntu_22_04"
  bundle_id         = "nano_1_0"
  key_pair_name     = aws_lightsail_key_pair.outline_instance_key_pair.name
}

resource "aws_lightsail_static_ip" "outline_instance_static_ip" {
  name = "${var.name}-outline-static-ip"
}

resource "aws_lightsail_static_ip_attachment" "outline_ip_attachment" {
  static_ip_name = aws_lightsail_static_ip.outline_instance_static_ip.name
  instance_name  = aws_lightsail_instance.outline_instance.name
}

resource "aws_lightsail_key_pair" "outline_instance_key_pair" {
  name = "${var.name}-outline-keypair"
}

output "instance_ip" {
  value = aws_lightsail_static_ip.outline_instance_static_ip.ip_address
}

output "key_pair" {
  sensitive = true
  value = aws_lightsail_key_pair.outline_instance_key_pair.private_key
}