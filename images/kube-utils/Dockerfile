FROM lachlanevenson/k8s-kubectl

ENV HELM_VERSION 2.2.1
ADD https://kubernetes-helm.storage.googleapis.com/helm-v$HELM_VERSION-linux-amd64.tar.gz /tmp/helm.tar.gz

RUN tar -zxf /tmp/helm.tar.gz -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp/*

ENTRYPOINT ["/bin/helm"]