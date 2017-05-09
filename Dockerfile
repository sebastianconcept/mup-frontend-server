FROM debian
MAINTAINER Sebastian Sastre

COPY lib/install-nginx.sh /tmp/install-nginx.sh
RUN bash /tmp/install-nginx.sh
RUN rm /tmp/install-nginx.sh

COPY lib /tmp/lib
RUN bash /tmp/lib/copy-files.sh

EXPOSE 80
EXPOSE 443
RUN chmod +x /verify.sh /start.sh
