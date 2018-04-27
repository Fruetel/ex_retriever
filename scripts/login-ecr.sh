#!/usr/bin/env bash
echo "Start logging in ECS"
mkdir ~/.aws;
which python
pip install awscli --ignore-installed six;
echo "[default]\naws_access_key_id=$BUILD_ACCESS_KEY\naws_secret_access_key=$BUILD_SECRET_KEY" > ~/.aws/credentials;
echo "[default]\nregion=$AWS_ECR_REGION" > ~/.aws/config;
login_string=`/usr/local/bin/aws ecr get-login --region eu-west-1`;
eval $login_string;
