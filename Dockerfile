FROM alpine

LABEL "repository"="http://github.com/giantswarm/image-optimizer-action"
LABEL "homepage"="http://github.com/giantswarm/image-optimizer-action"

LABEL "com.github.actions.name"="Image Optimization"
LABEL "com.github.actions.description"="Optimize images (JPEGs) pushed to a branch"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="yellow"

RUN apk --no-cache add jq bash git curl

RUN curl -s -L https://github.com/google/guetzli/releases/download/v1.0.1/guetzli_linux_x86-64 > /usr/bin/guetzli \
  && chmod +x /usr/bin/guetzli \
  && ls -la /usr/bin/guetzli

ADD lib.sh /lib.sh
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
