#===============================================================================
# Flow log IAM Resources
#===============================================================================

resource "aws_iam_role" "vpc_flow_log" {
  name = "${var.name}-vpc_flow_log_role-${data.aws_region.current.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "vpc-flow-logs.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
   ]
}
EOF
}

resource "aws_iam_role_policy" "vpc_flow_log" {
  name = "${var.name}_vpc_flow_log_policy"
  role = "${aws_iam_role.vpc_flow_log.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
       "Action": [
           "logs:CreateLogGroup",
           "logs:CreateLogStream",
           "logs:PutLogEvents",
           "logs:DescribeLogGroups",
           "logs:DescribeLogStreams"
         ],
         "Effect": "Allow",
         "Resource": "*"
      }
  ]
}
EOF
}

#===============================================================================
# Logrythm VPC Resources
#===============================================================================


resource "aws_cloudwatch_log_group" "flow_log" {
  name = "/aws/flowlog/${var.name}-flow-log-group"
}

resource "aws_flow_log" "vpc" {
  log_destination = "${aws_cloudwatch_log_group.flow_log.arn}"
#  log_group_name = "${aws_cloudwatch_log_group.flow_log.name}"
  iam_role_arn   = "${aws_iam_role.vpc_flow_log.arn}"
  vpc_id         = "${aws_vpc.main.id}"
  traffic_type   = "ALL"
}
