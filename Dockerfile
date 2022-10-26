FROM bash:latest
ARG TF_ARCH=linux_amd64
ARG TF_VERSION=1.3.3

RUN apk update
RUN apk add --no-cache curl unzip git python3 aws-cli && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN python3 -m pip install --no-cache --upgrade pip setuptools
RUN curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_${TF_ARCH}.zip --output /tmp/terraform_${TF_VERSION}_${TF_ARCH}.zip
RUN unzip /tmp/terraform_${TF_VERSION}_${TF_ARCH}.zip -d /tmp
RUN mv /tmp/terraform /bin
RUN rm /tmp/terraform_${TF_VERSION}_${TF_ARCH}.zip