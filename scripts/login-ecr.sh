#!/usr/bin/env bash
echo "Start logging in ECS"
mkdir ~/.aws;
pip install awscli --ignore-installed six;
printf "[default]\naws_access_key_id=$BUILD_ACCESS_KEY\naws_secret_access_key=$BUILD_SECRET_KEY\n" > ~/.aws/credentials;
printf "[default]\nregion=$AWS_ECR_REGION\n" > ~/.aws/config;
login_string=`/usr/bin/aws ecr get-login --no-include-email`;
eval $login_string;
