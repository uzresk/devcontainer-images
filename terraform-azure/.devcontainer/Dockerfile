FROM mcr.microsoft.com/azure-cli:latest

# check terraform version: https://www.terraform.io/downloads.html
ARG TERRAFORM_VERSION=1.5.4
# check tflint version: https://github.com/terraform-linters/tflint/releases
ARG TFLINT_VERSION=0.50.3
# check trivy version: https://github.com/aquasecurity/trivy/releases
ARG TRIVY_VERSION=0.49.1
# check aztfexport version: https://github.com/Azure/aztfexport/releases
ARG AZTFEXPORT_VERSION=0.14.0

RUN apk update \
    && apk add --no-cache curl unzip ca-certificates bash jq git

# install terraform, tflint, aztfexport
RUN cd /usr/local/bin \
    && if [[ -z "$TERRAFORM_VERSION" ]] ; then TERRAFORM_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M ".current_version") ; else echo TERRAFORM_VERSION=$TERRAFORM_VERSION ; fi \
    && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && rm -f terraform.zip \
    && curl -sSL https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip -o tflint_linux_amd64.zip \
    && unzip tflint_linux_amd64.zip \
    && rm tflint_linux_amd64.zip \
    && curl -sSL https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz -o trivy_Linux-64bit.tar.gz \
    && tar zxvf trivy_Linux-64bit.tar.gz \
    && rm trivy_Linux-64bit.tar.gz \
    && curl -sSL https://github.com/Azure/aztfexport/releases/download/v${AZTFEXPORT_VERSION}/aztfexport_v${AZTFEXPORT_VERSION}_linux_amd64.zip -o aztfexport_linux_amd64.zip \
    && unzip aztfexport_linux_amd64.zip \
    && rm aztfexport_linux_amd64.zip

# tflintの設定をルートディレクトリにコピー
ADD tflint/.tflint.hcl /root/
RUN cd /root/ \
   && tflint --init

# provider azurerm 3.49.0をローカルにmirrorする
RUN mkdir /root/terraform/ && mkdir /providers
ADD terraform-3.49.0/main.tf /root/terraform/
RUN cd /root/terraform && terraform providers mirror /providers

# provider azurerm 3.93.0をローカルにmirrorする
RUN rm -rf /root/terraform && mkdir /root/terraform
ADD terraform-3.93.0/main.tf /root/terraform/
RUN cd /root/terraform && terraform providers mirror /providers

# providerのダウンロード先をローカルファイルシステムに変更する
ADD terraformrc/.terraformrc /root/

# バージョンを出力
ADD post-start.sh /root/


