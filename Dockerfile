FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y --no-install-recommends --allow-unauthenticated install \
   build-essential \
   git \
   zip \
   unzip \
   xz-utils \
   wget \
   curl \
   ca-certificates \
   make \
   bash \
   bc \
   file \
   lzop

RUN dpkg --add-architecture i386 && \
   apt-get update && \
   apt-get -y --no-install-recommends --allow-unauthenticated install \
   libc6:i386 \
   libncurses5:i386 \
   libstdc++6:i386 \
   zlib1g:i386

# RUN adduser --disabled-password --gecos "" --uid 1001 runner \
#     && groupadd docker --gid 123 \
#     && usermod -aG sudo runner \
#     && usermod -aG docker runner \

# RUN addgroup --g 1000 groupcontainer
# RUN adduser -u 1000 -G groupcontainer -h /home/containeruser -D containeruser

# USER containeruser
# RUN apt-get install -y \
#    gcc-arm-none-eabi \
#    gcc-arm-linux-gnueabihf=4:10.2.1-1

# RUN apt-get install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu && \
#    ln -f -s /usr/aarch64-linux-gnu/lib/ld-linux-aarch64.so.1 /lib && \
#    ln -f -s /usr/aarch64-linux-gnu/lib/libc.so.6 /lib && \
#    ln -f -s /usr/aarch64-linux-gnu/lib/libdl.so.2 /lib && \
#    ln -f -s /usr/aarch64-linux-gnu/lib/libm.so.6 /lib
   
# RUN cd /opt; \
#    wget https://developer.arm.com/-/media/Files/downloads/gnu-a/10.3-2021.07/binrel/gcc-arm-10.3-2021.07-aarch64-arm-none-linux-gnueabihf.tar.xz; \
#    tar xvfJ gcc-arm-10.3-2021.07-aarch64-arm-none-linux-gnueabihf.tar.xz; \
#    rm gcc-arm-10.3-2021.07-aarch64-arm-none-linux-gnueabihf.tar.xz

RUN cd /opt; \
   wget https://github.com/dirkarnez/crosstool-ng-prebuilt/releases/download/v20251209/arm-cortexa9_neon-linux-gnueabihf.zip && \
   unzip arm-cortexa9_neon-linux-gnueabihf.zip -d arm-cortexa9_neon-linux-gnueabihf && \
   /opt/arm-cortexa9_neon-linux-gnueabihf/bin/arm-cortexa9_neon-linux-gnueabihf-gcc --version && \
   rm arm-cortexa9_neon-linux-gnueabihf.zip && \
   chmod -R 777 .

RUN mkdir /workspace
RUN mkdir /dist

COPY . /workspace
WORKDIR /workspace
VOLUME /dist

CMD [ "bash", "./make-linux.sh" ]
