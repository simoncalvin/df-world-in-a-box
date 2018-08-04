FROM ubuntu

RUN apt-get update && \
    apt-get install -y \
	libsdl-image1.2 \
	libsdl-ttf2.0-0 \
	libgtk2.0-0 \
	libglu1-mesa \
	libopenal1 \
	xvfb


WORKDIR /df

COPY df_linux /df

RUN export DISPLAY=:1

ENTRYPOINT exec Xvfb :1 -screen 0 1024x768x16 && \
	   bash



