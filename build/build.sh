#!/bin/bash

set -e

env

if ["$ENV" == "dev"]; then
   CREDS=$(aws sts assume-role role-arn $dev_build_role --role-session-name sls-session --out json)
   export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .Credentials.AccessKeyId)
   export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .Credentials.SecretAccessKey)
   export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .Credentials.SessionToken)
elif ["$ENV" == "qa"]; then
   CREDS=$(aws sts assume-role role-arn $qa_build_role --role-session-name sls-session --out json)
   export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r .Credentials.AccessKeyId)
   export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r .Credentials.SecretAccessKey)
   export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r .Credentials.SessionToken)
else
   echo "Unable to identify environment"
fi

echo "variables....."
env
