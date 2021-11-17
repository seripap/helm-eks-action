FROM alpine:3.13

ARG KUBECTL_VERSION="1.19.6"

RUN apk add py-pip curl wget ca-certificates git bash jq gcc alpine-sdk
RUN pip install 'awscli==1.20.8'
RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator

RUN wget https://get.helm.sh/helm-v3.6.2-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm 
RUN chmod +x /usr/local/bin/helm

ENV HELM_PLUGIN_DIR /.helm/plugins/helm-diff
RUN helm plugin install https://github.com/seripap/helm-ssm
#RUN wget https://github.com/codacy/helm-ssm/releases/download/3.1.9/helm-ssm-linux.tgz
#RUN echo $HELM_PLUGINS
#RUN tar xf helm-ssm-linux -C "$HELM_PLUGINS/helm-ssm"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]:
