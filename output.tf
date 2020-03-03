output "id" {
  value = "${aws_instance.this.id}"
}

output "eip_id" {
  value = "${element(coalescelist(aws_eip.this.*.id,list("")),0)}"
}

output "eip_instance" {
  value = "${element(coalescelist(aws_eip.this.*.instance,list("")),0)}"
}

output "private_ip" {
  value = "${aws_instance.this.private_ip}"
}

output "public_ip" {
  value = "${coalesce(element(coalescelist(aws_eip.this.*.public_ip,list("")),0),aws_instance.this.public_ip)}"
}
