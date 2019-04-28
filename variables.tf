variable "availability_zone_id" {
  description = "AZ used to create EC2 instances."
  default = "ap-south-1a"
}

variable "instance_type" {
  default     = "t2.medium"
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
}

variable "ami_version" {
  default     = "ami-0a574895390037a62"
  description = "the ami version - e.g. v1.0.0"
}

variable "root_block_device" {
  default     = "30"
  description = "size of root block device in GB"
}

variable "access_key" {
  description = "AWS account access key"
  default = ""
}

variable "secret_key" {
  description = "AWS account secret key"
  default = ""
}

variable "region" {
  description = "Default aws region"
  default = "ap-south-1"
}

