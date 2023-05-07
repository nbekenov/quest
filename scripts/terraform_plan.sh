#!/usr/bin/env bash

set -u # generate exception if variable is not set.

FOLDERS=$1
ENV_NAME=$2

function tf_validate {
    echo "Runnning terraform validate ..."
    terraform validate -no-color
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "terraform validate command failed with exit code ${exit_code}."
        exit $exit_code
    fi
    echo "terraform validate - finished successfully"
    echo "=========================================="
    echo "Runnning terraform format check ..."
    terraform fmt -check -no-color
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "terraform fmt -check command failed with exit code ${exit_code}."
        exit $exit_code
    fi
    echo "terraform format check - finished successfully"
    echo "=========================================="
}

function run_tflint {
    echo "Runnning tflint ..."
    tflint --init
    tflint
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "tflint command failed with exit code ${exit_code}."
        exit $exit_code
    fi
    echo "tflint - finished successfully"
    echo "=========================================="
}

function run_checkov {
    echo "running checkov ..."
    pwd
    checkov --directory .
    exit_code=$?
    checkov -o junitxml --framework terraform -d ./ > reports/checkov_app.xml
    if [ $exit_code -ne 0 ]; then
        echo "checkov command failed with exit code ${exit_code}."
        # exit $exit_code
    fi
    echo "checkov checks - finished successfully"
    echo "=========================================="
}

function run_plan {
    echo "## TERRAFORM PLAN : Generate the Terraform Plan"
    terraform plan -no-color -out plan.out
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "terraform plan command failed with exit code ${exit_code}."
        exit $exit_code
    fi
    echo "terraform plan - finished successfully"
    echo "=========================================="
}

IFSsave="$IFS"
IFS=,
vars=( $FOLDERS )
IFS="$IFSsave"
for((i=0;i<${#vars[@]};i++))
do
    TERRAFORM_FOLDER=${vars[i]}
    echo "current folder $TERRAFORM_FOLDER"
    cd ${TERRAFORM_FOLDER}
    mkdir -p reports
    echo "Initializing terraform backend for ${ENV_NAME} environment..."
    terraform init
    terraform workspace select ${ENV_NAME} || terraform workspace new ${ENV_NAME}
    tf_validate
    # run_tflint
    run_checkov
    run_plan
done