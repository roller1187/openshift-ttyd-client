# Use RHE7 as the base image (UBI7)
FROM registry.access.redhat.com/ubi7/ubi

LABEL maintainer="Andres Romero <aromero@redhat.com>"

LABEL name="registry.access.redhat.com/ubi7/ubi" \
      architecture="x86_64" \
      io.k8s.display-name="oc tools via ttyd" \
      io.k8s.description="Provides oc cli tooling via ttyd" \
      io.openshift.tags="openshift,ttyd,oc"
      
# Install oc client version 3.11.104
RUN curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v3/clients/3.11.104/linux/oc.tar.gz && \
    tar -xzvf /tmp/oc.tar.gz -C /tmp/ && \
    mv /tmp/oc /usr/local/bin/ && \
    rm -rf /tmp/oc.tar.gz

# Install ttyd version 1.5.0
RUN curl -sLo /tmp/ttyd https://github.com/tsl0922/ttyd/releases/download/1.5.0/ttyd_linux.x86_64 && \
    chmod 755 /tmp/ttyd

# Add ttyd user
RUN groupadd -r ttyd -g 2001 && \
    useradd -u 2001 -r -g ttyd -m -d /ttyd -s /bin/bash ttyd && \
    chmod 755 /ttyd

USER ttyd
ENV KUBECONFIG=/tmp/.kube/config

RUN oc version

EXPOSE 8080

# Run app as ttyd (2001/2001 - uid/gid)
ENTRYPOINT ["/tmp/ttyd", "-p", "8080", "-u", "2001", "-g", "2001", "bash", "-x"]
