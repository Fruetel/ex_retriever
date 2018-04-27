#!/usr/bin/env bash
echo "Start logging in ECS"
mkdir ~/.aws;
pip install awscli --ignore-installed six;
echo "[default]\naws_access_key_id=$BUILD_ACCESS_KEY\naws_secret_access_key=$BUILD_SECRET_KEY" > ~/.aws/credentials;
echo "[default]\nregion=$AWS_ECR_REGION" > ~/.aws/config;
cat ~/.aws/credentials;
login_string=`/usr/bin/aws ecr get-login --region eu-west-1`;
eval $login_string;
