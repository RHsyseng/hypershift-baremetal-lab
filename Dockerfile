FROM docker.io/antora/antora:latest as builder

COPY . /antora/

RUN antora generate --stacktrace site.yml

FROM registry.access.redhat.com/rhscl/httpd-24-rhel7:latest

COPY --from=builder /antora/gh-pages/ /var/www/html/
