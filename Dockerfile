FROM bash:latest
ARG TF_ARCH=linux_amd64
ARG TF_VERSION=1.8.3

RUN apk update
RUN apk add --no-cache
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.15/main" | tee -a /etc/apk/repositories
RUN echo "https://dl-cdn.alpinelinux.org/alpine/v3.15/community/" | tee -a /etc/apk/repositories
RUN apk add --no-cache bash coreutils build-base gcc musl-dev curl wget python3 python3-dev py3-pip pipx libffi-dev libressl libffi-dev libressl-dev libxslt-dev libxml2-dev=2.9.14-r2 libxml2
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m venv /venv
RUN . /venv/bin/activate
RUN /venv/bin/python3 -m pip install --no-cache --upgrade pip setuptools
RUN /venv/bin/python3 -m pip install --no-cache -r /tmp/requirements.txt
RUN /venv/bin/python3 -m pip install --no-cache azure-cli
RUN /venv/bin/python3 -m ensurepip
RUN curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_${TF_ARCH}.zip --output /tmp/terraform_${TF_VERSION}_${TF_ARCH}.zip
RUN unzip /tmp/terraform_${TF_VERSION}_${TF_ARCH}.zip -d /tmp
RUN mv /tmp/terraform /bin/terraform
RUN rm /tmp/terraform_${TF_VERSION}_${TF_ARCH}.zip
RUN curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" --output /tmp/kubectl
RUN mv /tmp/kubectl /bin/kubectl
RUN chmod +x /bin/kubectl