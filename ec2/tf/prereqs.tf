provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "kops-store" {
  bucket = "kops.store.${var.rig-domain}"
  acl = "private"
  region = "${var.region}"
  force_destroy= true
}

resource "aws_ebs_volume" "jenkins-home" {
  availability_zone = "${var.region}${var.jenkins-ebs-zone}"
  size = 20
  tags {
    rig-domain = "${var.rig-domain}"
    app = "jenkins"
  }
}

output "jenkins-home.id" {
  value = "${aws_ebs_volume.jenkins-home.id}"
}