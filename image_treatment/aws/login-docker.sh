aws_region=us-east-1
aws_account_id=219163670532

aws --region ${aws_region} ecr get-login-password \
    | docker login \
        --password-stdin \
        --username AWS \
        "${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com"