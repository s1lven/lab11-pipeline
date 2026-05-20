variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = can(regex("^t[23]\\..*", var.instance_type))
    error_message = "Instance type must be t2 or t3 family."
  }
}

variable "allowed_ports" {
  description = "List of ports to allow inbound"
  type        = list(number)
  default     = [22, 80]

  validation {
    condition     = alltrue([for p in var.allowed_ports : p > 0 && p <= 65535])
    error_message = "All ports must be between 1 and 65535."
  }
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to launch the instance in"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
