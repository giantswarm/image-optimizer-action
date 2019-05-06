FROM alpine

LABEL "repository"="http://github.com/giantswarm/image-optimizer-action"
LABEL "homepage"="http://github.com/giantswarm/image-optimizer-action"

LABEL "com.github.actions.name"="Image Optimization"
LABEL "com.github.actions.description"="Optimize images (JPEGs) pushed to a branch"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="yellow"

RUN apk --no-cache add jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
