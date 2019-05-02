FROM alpine:3.9

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="helm-kubectl" \
      org.label-schema.url="https://hub.docker.com/r/dtzar/helm-kubectl/" \
      org.label-schema.vcs-url="https://github.com/dtzar/helm-kubectl" \
      org.label-schema.build-date=$BUILD_DATE


ENV KUBE_LATEST_VERSION="v1.10.0"
ENV HELM_VERSION="v2.12.2"
ENV KSONNET_VERSION="0.13.1"

RUN apk update \
	&& apk add --update py-pip ca-certificates wget \
	&& pip install 'docker-compose==1.10' \
	&& update-ca-certificates \
	&& apk --update add --no-cache qemu-system-x86_64 libvirt openrc make ca-certificates bash git curl docker gcc autoconf findutils pkgconf libtool g++ automake linux-headers \
	&& wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
	&& chmod +x /usr/local/bin/kubectl \
	&& wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
	&& chmod +x /usr/local/bin/helm \
	&& wget -q https://github.com/ksonnet/ksonnet/releases/download/v${KSONNET_VERSION}/ks_${KSONNET_VERSION}_linux_amd64.tar.gz \
	&& tar zxvf ks_${KSONNET_VERSION}_linux_amd64.tar.gz \
	&& cp ks_${KSONNET_VERSION}_linux_amd64/ks /usr/local/bin \
	&& chmod +x /usr/local/bin/ks \
	&& rm -r ks_${KSONNET_VERSION}_linux_amd64/

CMD ["bash"]
