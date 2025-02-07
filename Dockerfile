FROM debian:bullseye-slim

LABEL maintainer="Mark Ley - report issues & requests here https://github.com/goatie999/nginx-rtmps-docker"

# Update and Load initial packages
RUN apt-get update && \
	apt-get install -y nano nginx libnginx-mod-rtmp stunnel4

# Import setting files and set new files
COPY nginx.conf /etc/nginx/nginx.conf
COPY stunnel.conf /etc/stunnel/stunnel.conf
RUN touch /var/log/stunnel4/stunnel.log


# Make any configuration changes to nginx anf stunnel
# RUN more /etc/nginx/nginx.setup >> /etc/nginx/nginx.conf
RUN echo "ENABLED=1" >> /etc/default/stunnel4

# Expose services to host
EXPOSE 1935

# Forward logs to Docker
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log
#    ln -sf /dev/stdout /var/log/stunnel4/stunnel.log


#STRIPCHAT
ENV STRIPCHAT_URL rtmp://s-sd.stripst.com/ext
ENV STRIPCHAT_KEY ""


#BONGAMODELS
ENV BONGAMODELS_URL rtmp://origin.bcvidorigin.com:1934/live
ENV BONGAMODELS_KEY ""


ENV CHATURBATE_URL rtmp://live.stream.highwebmedia.com/live-origin
ENV CHATURBATE_KEY ""

#CAM4
ENV CAM4_URL rtmp://origin.cam4.com/cam4-origin-live
ENV CAM4_KEY ""

#Setup Streaming Services Details
#Facebook
ENV FACEBOOK_URL rtmp://localhost:19350/rtmp/
ENV FACEBOOK_KEY ""

#Restream.io
ENV RESTREAM_URL rtmp://live.restream.io/live/
ENV RESTREAM_KEY ""

#YouTube
ENV YOUTUBE_URL rtmp://a.rtmp.youtube.com/live2/
ENV YOUTUBE_KEY ""

#Twitch
ENV TWITCH_URL rtmp://live.twitch.tv/app/
ENV TWITCH_KEY ""

#MixCloud
ENV MIXCLOUD_URL rtmp://rtmp.mixcloud.com/broadcast/
ENV MIXCLOUD_KEY ""

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 1935

ENTRYPOINT ["/entrypoint.sh"]

# Initialise nginx
CMD ["nginx", "-g", "daemon off;"]
