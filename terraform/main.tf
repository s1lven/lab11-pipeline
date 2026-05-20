module "vpc" {
  source = "./modules/vpc"

  vpc_name             = "week9-vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]

  tags = {
    Project     = "CloudComputing"
    Week        = "9"
    Environment = terraform.workspace
  }
}

module "ec2" {
  source = "./modules/ec2"

  instance_name = "week9-instance"
  instance_type = "t3.micro"
  allowed_ports = [22, 80, 443]
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_ids[0]

  tags = {
    Project     = "CloudComputing"
    Week        = "9"
    Environment = terraform.workspace
  }
}

module "rds" {
  source = "./modules/rds"

  db_identifier = terraform.workspace == "default" ? "week9-db" : "week9-${terraform.workspace}-db"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids
  db_username   = "dbadmin"
  db_password   = "Password1234!"

  tags = {
    Project     = "CloudComputing"
    Week        = "9"
    Environment = terraform.workspace
  }
}
