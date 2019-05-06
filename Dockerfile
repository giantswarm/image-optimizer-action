FROM alpine AS builder

RUN apk --no-cache add curl build-base libpng-dev

RUN curl -s -L https://github.com/google/guetzli/archive/v1.0.1.tar.gz > guetzli-1.0.1.tar.gz && \
  tar xvzf guetzli-1.0.1.tar.gz && \
  cd guetzli-1.0.1 && \
  make && \
  mv bin/Release/guetzli /usr/bin/guetzli


FROM alpine

LABEL "repository"="http://github.com/giantswarm/image-optimizer-action"
LABEL "homepage"="http://github.com/giantswarm/image-optimizer-action"

LABEL "com.github.actions.name"="Image Optimization"
LABEL "com.github.actions.description"="Optimize images (JPEGs) pushed to a branch"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="yellow"

RUN apk --no-cache add jq bash git file libpng libstdc++

COPY --from=builder /usr/bin/guetzli /usr/bin/guetzli

ADD lib.sh /lib.sh
#ADD entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]
