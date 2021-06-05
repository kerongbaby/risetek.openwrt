FROM debian:buster

# Install openwrt depends
RUN apt-get update \
    && apt-get install --no-install-recommends -y sudo git-core build-essential gcc-multilib \
       libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python curl nano libssl-dev time  \
       ca-certificates python3 file make patch rsync \
        && apt-get autoclean \
        && apt-get clean \
        && apt-get autoremove \
        && rm -rf /var/lib/apt/lists/*

RUN useradd -m openwrt && echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt \
    && git config --global user.name "wangyc@risetek.com" && git config --global user.email "wangyc@risetek.com" \
    && echo export LS_COLORS='$LS_COLORS':\''di=01;35':\' >> /home/openwrt/.bashrc

COPY docker-entrypoint.sh /entrypoint.sh
ADD --chown=openwrt:openwrt build-*.sh /home/openwrt/

RUN chmod +x /home/openwrt/build-*.sh && chmod +x /entrypoint.sh

USER openwrt
COPY src/ /home/openwrt/targets/
COPY devices/ /home/openwrt/devices/

## Clone openwrt, Update and install feeds, and packet it to openwrt home.
## All jobs done at directory /tmp, so clean it when finished.
WORKDIR /tmp
RUN set -ex && git clone --depth=1 https://git.openwrt.org/openwrt/openwrt.git \
    && ./openwrt/scripts/feeds update -a && ./openwrt/scripts/feeds install -a \
    && tar -zcf ~/openwrt.sources.tgz openwrt && cd /tmp && sudo rm -rf *

ENTRYPOINT ["/entrypoint.sh"]

VOLUME  /workspace
WORKDIR /workspace
CMD ["/bin/bash"]
