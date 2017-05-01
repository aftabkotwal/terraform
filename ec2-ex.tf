provider "aws" {
  access_key = "${var.access_key}" 
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "myfirstTF" {
  ami           = "${lookup(var.amis , var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"

connection {
   user = "${lookup(var.user, var.platform)}"
   private_key = "${file("${var.key_path}")}"
     }
provisioner "local-exec" {
    command = "echo ${aws_instance.myfirstTF.public_ip} > ip_address.txt"
     }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.myfirstTF.id}"
}

resource "aws_security_group" "myec2instance" {
    name = "myec2instance_${var.platform}"
    description = "EC2  internal traffic + maintenance."

    // These are for internal traffic
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }

    // These are for maintenance
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // This is for outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

