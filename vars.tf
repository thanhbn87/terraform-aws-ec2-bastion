variable "name" {}
variable "namespace" { default = "" }
variable "project_env" { default = "Development" }
variable "project_env_short" { default = "dev" }
variable "instance_type" {}
variable "ami" {}

variable "delete_on_termination" { default = false }
variable "iam_instance_profile" {}
variable "protect_termination" { default = true }
variable "cpu_credits" { default = "unlimited" }

variable "key_name" {}
variable "vpc_security_group_ids" { default = [] }
variable "subnet_id" {}
variable "volume_size" { default = "20" }
variable "ebs_optimized" { default = true }
variable "user_data_file" { default = "" }

variable "tags" { default = {} }

// CloudWatch:
variable "ec2_autorecover" { default = true }
variable "cw_eval_periods" { default = "2" }
variable "cw_period" { default = "60" }
variable "cw_statistic" { default = "Minimum" }
variable "cw_comparison" { default = "GreaterThanThreshold" }
variable "cw_threshold" { default = "0.0" }
variable "cw_recover_metric" { default = "StatusCheckFailed_System" }
