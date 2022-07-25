resource "aws_elastic_beanstalk_application" "beanstalk_app" {
  name = var.reponame

/*
  appversion_lifecycle {
    service_role = aws_iam_role.beanstalk_ec2.arn
    max_count = 2
    delete_source_from_s3 = true
  }
*/
}

resource "aws_elastic_beanstalk_environment" "beanstalk_env" {
  application = aws_elastic_beanstalk_application.beanstalk_app.name
  name        = var.reponame
  # https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = "64 Amazon Linux 2 v3.4.17 running Docker"

  setting {
    name      = "aws:autoscaling:launchconfiguration"
    namespace = "InstanceType"
    value     = var.ec2Size
  }

  setting {
    name      = "aws:autoscaling:asg"
    namespace = "MaxSize"
    value     = var.ec2SizeMaximo
  }

  setting {
    name      = "aws:autoscaling:launchconfiguration"
    namespace = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_ec2_profile.name
  }
}

resource "aws_elastic_beanstalk_application_version" "v1" {
  depends_on = [aws_elastic_beanstalk_environment.beanstalk_env,
    aws_elastic_beanstalk_application.beanstalk_app,
    aws_s3_object.dockerrun_json]

  application = aws_elastic_beanstalk_application.beanstalk_app.name
  bucket      = aws_s3_bucket.dockerrun.id
  key         = aws_s3_object.dockerrun_json.id
  name        = var.reponame
}