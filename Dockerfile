FROM mariadb:latest
LABEL maintainer="Mpho raf < mphoraf @ gmail . com >"

ENV BRUCE=WAYNE

EXPOSE 3307

RUN echo "$BRUCE" > /BATCAVE
