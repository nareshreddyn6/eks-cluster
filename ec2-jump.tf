resource "aws_instance" "ec2-jump" {
  ami             = "ami-05fa00d4c63e32376"
  instance_type   = "t3.small"
  subnet_id       = aws_subnet.self-managed-public-subnet.id
  security_groups = [aws_security_group.ec2-jump-sg.name]
  key_name      = "self-managed-key-pair"
 

  tags = {
    Name = "ec2-jump"
    
  }
}
  
resource "aws_eip" "ec2-jump-eip" {
  vpc = true
   tags = {
    Name = "ec2-jump-eip"
  } 
}
  
resource "aws_eip_association" "ec2-jump-eip-asc" {
  instance_id   = aws_instance.ec2-jump.id
  allocation_id = aws_eip.ec2-jump-eip.id
}








resource "aws_security_group" "ec2-jump-sg" {
  name = "ec2-jump-sg"
  
  vpc_id = aws_vpc.self_managed_vpc.id

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