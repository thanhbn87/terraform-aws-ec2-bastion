locals {
  name        = "${var.namespace == "" ? lower(var.name) : "${lower(var.namespace)}-${lower(var.name)}"}"
  common_tags = {
    Env  = "${var.project_env}"
    Name = "${local.name}"
  }
}

resource "aws_instance" "this" {
  instance_type = "${var.instance_type}"
  ami           = "${var.ami}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }

  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${var.vpc_security_group_ids}"]
  subnet_id                   = "${var.subnet_id}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  disable_api_termination     = "${var.protect_termination}"
  ebs_optimized               = "${var.ebs_optimized}"
  user_data                   = "${var.user_data}"
  associate_public_ip_address = "${var.associate_public_ip_address}"

  credit_specification {
    cpu_credits = "${var.cpu_credits}"
  }

  tags = "${merge(var.tags,local.common_tags)}"

  lifecycle {
    ignore_changes = ["user_data", "associate_public_ip_address"]
  }

}

//////////////////////////////////////////////
////// EIP:
//////////////////////////////////////////////
resource "aws_eip" "this" {
  count    = "${var.associate_public_ip_address ? 0 : 1}"
  vpc      = true
  instance = "${aws_instance.this.id}"
  tags     = "${merge(var.tags,local.common_tags)}"
}

//////////////////////////////////////////////
////// CloudWatch:
//////////////////////////////////////////////
data "aws_region" "this" {}
resource "aws_cloudwatch_metric_alarm" "ec2_recover" {
  count               = "${var.ec2_autorecover ? 1 : 0}"
  alarm_name          = "ec2-recovery-${lower(var.name)}"
  namespace           = "AWS/EC2"
  evaluation_periods  = "${var.cw_eval_periods}"
  period              = "${var.cw_period}"
  alarm_description   = "Auto recover ${lower(var.name)} instance"
  alarm_actions       = ["arn:aws:automate:${data.aws_region.this.name}:ec2:recover"]
  statistic           = "${var.cw_statistic}"
  comparison_operator = "${var.cw_comparison}"
  threshold           = "${var.cw_threshold}"
  metric_name         = "${var.cw_recover_metric}"

  dimensions {
    InstanceId = "${aws_instance.this.id}"
  }
}
