resource "aws_instance" "bastion" {
  instance_type = "${var.instance_type}"
  ami           = "${var.ami}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }

  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${var.vpc_security_group_ids}"]
  subnet_id               = "${var.subnet_id}"
  iam_instance_profile    = "${var.iam_instance_profile}"
  disable_api_termination = "${var.protect_termination}"
  ebs_optimized           = "${var.ebs_optimized}"

  credit_specification {
    cpu_credits = "${var.cpu_credits}"
  }

  tags {
    Name = "${var.name}"
    Env  = "${var.project_env}"
  }

}

//////////////////////////////////////////////
////// EIP:
//////////////////////////////////////////////
resource "aws_eip" "eip_bastion" {
  vpc = true
  instance    = "${aws_instance.bastion.id}"

  tags {
    Name = "${var.namespace == "" ? "" : "${var.namespace}-"}${var.name}"
  }
}

//////////////////////////////////////////////
////// CloudWatch:
//////////////////////////////////////////////
resource "aws_cloudwatch_metric_alarm" "ec2_recover" {
  count               = "${var.ec2_autorecover ? 1 : 0}"
  alarm_name          = "ec2-recovery-${lower(var.name)}"
  namespace           = "AWS/EC2"
  evaluation_periods  = "${var.cw_eval_periods}"
  period              = "${var.cw_period}"
  alarm_description   = "Auto recover ${lower(var.name)} instance"
  alarm_actions       = ["arn:aws:automate:${var.aws_region}:ec2:recover"]
  statistic           = "${var.cw_statistic}"
  comparison_operator = "${var.cw_comparison}"
  threshold           = "${var.cw_threshold}"
  metric_name         = "${var.cw_recover_metric}"

  dimensions {
    InstanceId = "${aws_instance.bastion.id}"
  }
}
