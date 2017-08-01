FROM alpine:3.6
# https://caddyserver.com/download/linux/amd64?plugins=http.authz,http.awslambda,http.cgi,http.cors,http.datadog,http.expires,http.filemanager,http.filter,http.git,http.hugo,http.ipfilter,http.jwt,http.login,http.mailout,http.minify,http.prometheus,http.proxyprotocol,http.ratelimit,http.realip,http.upload
# inspired by https://github.com/ZZROTDesign/alpine-caddy
ARG CADDY_OS=linux
ENV CADDY_OS $CADDY_OS

ARG CADDY_ARCH=amd64
ENV CADDY_ARCH $CADDY_ARCH

ARG CADDY_PLUGINS=http.filemanager
ENV CADDY_PLUGINS $CADDY_PLUGINS

RUN apk --no-cache add tini git tar curl openssh-client && \
    apk --no-cache add --virtual devs tar curl && \
    curl "https://caddyserver.com/download/${CADDY_OS}/${CADDY_ARCH}${CADDY_ARM}?plugins=${CADDY_PLUGINS}" | tar --no-same-owner -C /usr/bin/ -xz caddy && \
    apk del devs && \
    rm -rf /tmp/* /var/cache/apk/* /usr/share/man

EXPOSE 80 443 2015 

#Copy over a default Caddyfile
COPY ./public /public
ONBUILD COPY ./public /public

COPY ./Caddyfile /etc/Caddyfile
ONBUILD COPY ./Caddyfile /etc/Caddyfile

#USER caddy

ENTRYPOINT ["/sbin/tini"]

CMD ["caddy", "-agree", "-conf", "/etc/Caddyfile", "-quic"]