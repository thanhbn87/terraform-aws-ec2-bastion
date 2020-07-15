variable "name" {
  description = "The name of the instance"
  type        = string
}
variable "namespace" {
  description = "The namespace of the instance"
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "The instance type of the instance"
  type        = string
}
variable "ami" {
  description = "The AMI of the instance"
  type        = string
}
variable "iam_instance_profile" {
  description = "The instance_profile to use"
  type        = string
}
variable "protect_termination" { 
  description = "Whether or not the instance will be protected from termination"
  type        = bool
  default     = true
}
variable "cpu_credits" {
  description = "The CPU credits to use"
  type        = string
  default     = "unlimited"
}
variable "key_name" {
  description = "The name of SSH Key Pair"
  type        = string
}
variable "vpc_security_group_ids" {
  description = "The list of security groups"
  type        = list(string)
  default = []
}
variable "subnet_id" {
  description = "The subnet_id of the instance"
  type        = string
}
variable "ebs_optimized" { 
  description = "Whether or not the ebs is optimized"
  type        = bool
  default     = true
}
variable "associate_public_ip_address" {
  description = "Whether or not assign public ip for the instance"
  type        = bool
  default     = false
}
variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}
variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = " "
}

variable "tags" {
  description = "Tags of the instance"
  type        = map
  default = {}
}

// CloudWatch:
variable "ec2_autorecover" {
  description = "Whether or not use CloudWatch Recovery"
  type        = bool
  default     = true
}
variable "cw_eval_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
  type        = string
  default     = "2"
}
variable "cw_period" {
  description = "The period in seconds over which the specified statistic is applied"
  type        = string
  default     = "60"
}
variable "cw_statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  type        = string
  default     = "Minimum"
}
variable "cw_comparison" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
  type        = string
  default     = "GreaterThanThreshold"
}
variable "cw_threshold" {
  description = "The value against which the specified statistic is compared"
  type        = string
  default     = "0.0"
}
variable "cw_recover_metric" {
  description = "The name for the alarm's associated metric"
  type        = string
  default     = "StatusCheckFailed_System"
}
