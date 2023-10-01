resource "local_file" "ansible_inventory" {
filename = "../Ansible/inventory"
content = <<EOF
[outline]
hostname=outline ansible_ssh_host="${aws_lightsail_static_ip.outline_instance_static_ip.ip_address}" ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter = /usr/bin/python3
ssh_args = -o StrictHostKeyChecking=no -oCompression=yes
inventory = ./inventory
EOF
}

resource "local_file" "ansible_keypair" {
depends_on = [ aws_lightsail_instance.outline_instance, aws_lightsail_static_ip_attachment.outline_ip_attachment ]
filename = "../Ansible/key_pair"
file_permission = "0600"
content = <<EOF
${aws_lightsail_key_pair.outline_instance_key_pair.private_key}
EOF
provisioner "local-exec" {command = "sleep 10 && ansible-playbook --private-key ../Ansible/key_pair -i ../Ansible/inventory -v ../Ansible/main.yaml"}
}



