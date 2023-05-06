#!/usr/bin/env bash

# install Terraform, Checkov and TFLint
export TF_VERSION=1.3.7
export CHECKOV_VERSION=2.2.125
export  TFLINT_VERSION=0.39.1

wget -O terraform.zip "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip"
unzip terraform.zip && rm terraform.zip && mv terraform /usr/bin/terraform && chmod +x /usr/bin/terraform
echo "============================================================"
pip install checkov==${CHECKOV_VERSION}
echo "============================================================"
curl --location https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip --output tflint_linux_amd64.zip && \
unzip tflint_linux_amd64.zip && \
rm tflint_linux_amd64.zip
echo "============================================================"
curl --location https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v${TFLINT_AWS_RULESET_VERSION}/tflint-ruleset-aws_linux_amd64.zip --output tflint-ruleset-aws.zip && \
unzip tflint-ruleset-aws.zip -d ~/.tflint.d/plugins && \
rm tflint-ruleset-aws.zip