output "id" {
  value = "${aws_instance.this.id}"
}

output "eip_id" {
  value = "${aws_eip.this.id}"
}

output "eip_instance" {
  value = "${aws_eip.this.instance}"
}

output "private_ip" {
  value = "${aws_eip.this.private_ip}"
}

output "public_ip" {
  value = "${aws_eip.this.public_ip}"
}
