FROM docker:stable

MAINTAINER 王斌 <253498229@qq.com>

# https://docs.rancher.cn/rancher2x/install-prepare/download/ 查看最近版本

ENV TZ=Asia/Shanghai
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

ENV KUBE_LATEST_VERSION=v1.17.4
ENV HELM_VERSION=v3.0.3
ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz

RUN apk add --update ca-certificates \
&& apk add --update -t deps curl  \
&& apk add --update gettext tar gzip \
&& curl -L https://docs.rancher.cn/download/kubernetes/linux-amd64-${KUBE_LATEST_VERSION}-kubectl -o /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/kubectl \
&& curl -L https://docs.rancher.cn/download/helm/${HELM_FILENAME} | tar xz && mv linux-amd64/helm /bin/helm && rm -rf linux-amd64 \
&& apk del --purge deps \
&& rm /var/cache/apk/*
