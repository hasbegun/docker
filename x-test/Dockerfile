FROM ubuntu:18.04

RUN apt update && apt install -y x11-apps
# RUN rm -rf /tmp/* /usr/share/doc/* /usr/share/info/* /var/tmp/*
RUN useradd -ms /bin/bash user
# ENV DISPLAY :0

USER user
# ENTRYPOINT ["/bin/sh", "-c", "$0 \"$@\"", "xeyes"]
ENTRYPOINT ["xeyes"]
# CMD ["/bin/bash"]
