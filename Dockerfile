FROM python:3-alpine3.7

## Pull in main application and configure
RUN apk -U --no-progress upgrade && \
    apk --no-progress add gcc sqlite musl-dev zlib-dev jpeg-dev supervisor libjpeg-turbo git bash && \
    git clone https://github.com/spl0k/supysonic.git /app && \
    cd /app && pip install flup && python setup.py install && \
    pip install -e .[watcher] && \
    adduser -S -D -H -h /var/lib/supysonic -s /sbin/nologin -G users \
    -g supysonic supysonic && mkdir -p /var/lib/supysonic && \
    chown supysonic:users /var/lib/supysonic

## Add in required tooling for transcoding...
RUN apk add ffmpeg lame mpg123 vorbis-tools flac

RUN rm -rf /root/.ash_history /root/.cache /var/cache/apk/*

## Copy in additional scripts to bootstrap the app...
COPY docker /app/docker

ENV \
    SUPYSONIC_DB_URI="sqlite:////var/lib/supysonic/supysonic.db" \
    SUPYSONIC_SCANNER_EXTENSIONS="" \
    SUPYSONIC_SECRET_KEY="" \
    SUPYSONIC_WEBAPP_CACHE_DIR="/var/lib/supysonic/cache" \
    SUPYSONIC_LASTFM_API_KEY="" \
    SUPYSONIC_LASTFM_SECRET="" \
    SUPYSONIC_RUN_MODE="standalone"
    #SUPYSONIC_WEBAPP_LOG_FILE="/var/lib/supysonic/supysonic.log" \
    #SUPYSONIC_WEBAPP_LOG_LEVEL="WARNING" \
    #SUPYSONIC_DAEMON_LOG_FILE="/var/lib/supysonic/supysonic-daemon.log" \
    #SUPYSONIC_DAEMON_LOG_LEVEL="INFO" \

EXPOSE 5000

VOLUME [ "/var/lib/supysonic", "/media" ]

USER root

RUN touch /var/run/supervisor.sock && \
    chmod 777 /var/run/supervisor.sock

CMD ["/usr/bin/supervisord", "--configuration=/app/docker/supervisord.conf"]
