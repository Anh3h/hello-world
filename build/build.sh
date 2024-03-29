#!/bin/bash

set -e

env

if [ "$ENV" = "dev" ]; then
   CREDS=$(aws sts assume-role --role-arn $dev_build_role --role-session-name sls-session --out json)
   export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .Credentials.AccessKeyId)
   export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .Credentials.SecretAccessKey)
   export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .Credentials.SessionToken)
   export STAGE=dev
elif [ "$ENV" == "prod" ]; then
   CREDS=$(aws sts assume-role --role-arn $prod_build_role --role-session-name sls-session --out json)
   export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .Credentials.AccessKeyId)
   export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .Credentials.SecretAccessKey)
   export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .Credentials.SessionToken)
   export STAGE=prod
else
   echo "Unable to identify environment"
fi

echo "AccountID..........."
aws sts get-caller-identity --query Account --output text

echo "Running serverless deploy"
#sls deploy --stage=$STAGE --verbose
