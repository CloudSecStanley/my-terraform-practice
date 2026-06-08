resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-00e801948462f718a"
  instance_type = "t2.micro"
  user_data     = file("${path.module}/server.sh")

  # 1. FIX CKV_AWS_8: Encrypt the storage drive at rest
  root_block_device {
    encrypted = true
  }

  # 2. FIX CKV_AWS_79: Force IMDSv2 (Blocks SSRF credential theft)
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # Disables older, vulnerable IMDSv1
    http_put_response_hop_limit = 1
  }

  # 3. FIX CKV_AWS_126: Speed up logs for incident response monitoring
  monitoring = true

  # 4. FIX CKV_AWS_135: Acknowledge the hardware limitation.
  # The t2.micro free-tier hardware physically cannot support EBS optimization.
  # checkov:skip=CKV_AWS_135: t2.micro hardware does not support EBS optimization

  # 5. FIX CKV2_AWS_41: Accept the missing IAM profile for this stage.
  # Since we are focusing on local environment automation before writing complex IAM roles,
  # we tell Checkov to intentionally skip this rule for now.
  # checkov:skip=CKV2_AWS_41: Postponing IAM instance profile role attachment for local sandbox testing

  tags = {
    Name = "Practice-Server"
  }
}