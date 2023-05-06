#!/usr/bin/env bash

set -u 

SECRET_STRING=$1
SECRET_NAME="quest_secret_word"

if aws secretsmanager describe-secret --secret-id $SECRET_NAME --query 'ARN' --output text >/dev/null 2>&1; then  
    echo "Secret already exists.  Skipping creation"
else  
    echo "Secret does not exist. Creating ..."
    aws secretsmanager create-secret \
        --name $SECRET_NAME \
        --description "quest SECRET_WORD" \
        --secret-string $SECRET_STRING
    echo "Secret successfully created!"
fi


