FROM ubuntu:18.04

RUN apt-get update \
&& apt-get install -y \
libsdl-image1.2 \
libsdl-ttf2.0-0 \
libgtk2.0-0 \
libglu1-mesa \
libopenal1 \
xvfb

ENV DISPLAY :1

COPY df_linux /df_linux

RUN mkdir /world_gen

COPY ./docker-entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
&& ln -s /usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]



