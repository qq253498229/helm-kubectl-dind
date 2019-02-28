FROM docker:stable

MAINTAINER Sergii Nuzhdin <ipaq.lw@gmail.com@gmail.com>

# https://dl.k8s.io/release/stable.txt 查看最近版本

ENV KUBE_LATEST_VERSION=v1.13.3
ENV HELM_VERSION=v2.13.3
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz


RUN apk add --update ca-certificates \
 && apk add --update -t deps curl  \
 && apk add --update gettext tar gzip \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://github.com/helm/helm/archive/${HELM_VERSION}.tar.gz | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*