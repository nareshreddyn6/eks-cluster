resource "aws_key_pair" "self-managed-key-pair" {
  key_name   = "nodekey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL8h3XTJ1u+tNT39vawf8HgGkHGOnuc2g7TyjaQREoxLkVV4WpybJe0FW8rw37q6QjPh+uY9Q9NqdLKW+9QelIbASWqvT16j0Anp32G0h5KCPjXlxjibPG6t6JB97hjFid8VqAiJotAXg2689yBulupi93zXkS0OmiS/f5BIF9ZGq2J+PVWmovoeifSEuu32IItMV/YVP49ar3xW04q4gW1JT5EbmE860Gq1a3njCDesFQ5cgx9DFOYTbqB9EEhVbzztNwXUPvW16P66RTleUcen4y79dmTGr16wVjKztlUWx4goFAzp/GpydmZX/CAiEnQuSUVVcBVD8lUc6dKAApM+CYKpyBivgDIZFXpgPTzr2cxQ33SFIptmWi72AEfxxUGd4SjXl6KevKdgXWppNgdG4ZvS+kbcSg0Ss2JBhKkXaVFsCSClgt4WEsGuKRiPef3mE7mCAGnfpYdR1GaGLrhlXUcT754UomkVdf3KovqfW5t+IVBfX+h7rjlBqtqW0= root@ip-172-31-29-108"
}


resource "aws_instance" "ec2-jump" {
  ami             = "ami-08c40ec9ead489470"
  instance_type   = "t3.small"
  #subnet_id       = aws_subnet.self-managed-public-subnet.id
  #security_groups = [aws_security_group.ec2-jump-sg.name]
  vpc_security_group_ids = ["${aws_security_group.ec2-jump-sg.id}"]
   key_name      = "clientkey"
   #key_name      = aws_key_pair.self-managed-key-pair.key_name
  #depends_on        = ["aws_security_group.ec2-jump-sg"]

  tags = {
    Name = "ec2-jump"
    
  }




/* 
  provisioner "file" {
  source      = "nodekey"
  destination = "/home/ubuntu/nodekey"

    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("nodekey")
   # host     = "${aws_eip.ec2-jump-eip.public_ip}/32"
  host = "${self.public_ip}"
  }
   }

  provisioner "file" {
  source      = "ec2-jump.sh"
  destination = "/home/ubuntu/ec2-jump.sh"

      connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("nodekey")}"
   # host     = "${aws_eip.ec2-jump-eip.public_ip}/32"
  host = "${self.public_ip}"
  }
  
  }
  
  # Change permissions on bash script and execute from ec2-user.
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "chmod +x /home/ubuntu/ec2-jump.sh",
      "sudo /home/ubuntu/ec2-jump.sh",
    ]
        connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("nodekey")}"
   # host     = "${aws_eip.ec2-jump-eip.public_ip}/32"
  host = "${self.public_ip}"
  }
  } */

  

}

resource "null_resource" "copy_execute" {
  
    connection {
    type = "ssh"
    host = aws_instance.ec2-jump.public_ip
    user = "ubuntu"
    private_key = file("./clientkey.pem")
    }

 
  provisioner "file" {

  source      = "nodekey"
  destination = "/home/ubuntu/nodekey"
  }
  
   /* provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/httpd.sh",
      "sh /tmp/httpd.sh",
    ]
  } */
  
  depends_on = [ aws_instance.ec2-jump ]
  
  }



  
/* resource "aws_eip" "ec2-jump-eip" {
  vpc = true
   tags = {
    Name = "ec2-jump-eip"
  } 
}
  
resource "aws_eip_association" "ec2-jump-eip-asc" {
  instance_id   = aws_instance.ec2-jump.id
  allocation_id = aws_eip.ec2-jump-eip.id
} */

/* resource "aws_network_interface_sg_attachment" "ec2-jump-sg-attache" {
  security_group_id    = aws_security_group.ec2-jump-sg.id
  network_interface_id = aws_instance.ec2-jump.primary_network_interface_id
} */



resource "aws_security_group" "ec2-jump-sg" {
  name = "ec2-jump-sg"
  
  #vpc_id = aws_vpc.self_managed_vpc.id

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

 

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}




