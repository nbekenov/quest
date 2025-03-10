#!/usr/bin/env bash

# install Terraform, Checkov and TFLint
export TF_VERSION=1.3.7
export CHECKOV_VERSION=2.2.125
export TFLINT_VERSION=0.39.1

echo "Installing Terraform"
wget -O terraform.zip "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip"
unzip terraform.zip && rm terraform.zip && mv terraform /usr/bin/terraform && chmod +x /usr/bin/terraform
echo "============================================================"
echo "Installing Checkov"
pip install checkov==${CHECKOV_VERSION}
echo "============================================================"
echo "Installing TFLint"
curl --location https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip --output tflint.zip && \
unzip tflint.zip && rm tflint.zip && mv tflint /usr/bin/tflint && chmod +x /usr/bin/tflint
