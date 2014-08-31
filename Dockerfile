FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# Set apt mirror
RUN sed 's@archive.ubuntu.com@mirrors.centarra.com@' -i /etc/apt/sources.list

# enable backports and others off by default
RUN sed 's/^#\s*deb/deb/' -i /etc/apt/sources.list

# never install recommends automatically
RUN echo 'Apt::Install-Recommends "false";' > /etc/apt/apt.conf.d/docker-no-recommends

# Enable automatic preference to use backport
RUN echo 'Package: *'                      >> /etc/apt/preferences \
 && echo 'Pin: release a=trusty-backports' >> /etc/apt/preferences \
 && echo 'Pin-Priority: 500'               >> /etc/apt/preferences

# Install aptitude and add-apt-repository
RUN apt-get update
RUN apt-get install -y \
      aptitude \
      software-properties-common

# Set up PPAs
RUN add-apt-repository ppa:git-core/ppa

# Install base packages
RUN aptitude update \
 && aptitude install -y \
      build-essential \
      curl \
      exuberant-ctags \
      htop \
      ssh-client \
      git \
      manpages \
      zsh

# Install Docker-client
RUN curl -L https://get.docker.io/builds/Linux/x86_64/docker-latest > /bin/docker \
 && chmod +x /bin/docker

# Install Fig
RUN curl -L https://github.com/docker/fig/releases/download/0.5.2/linux > /usr/local/bin/fig \
 && chmod +x /usr/local/bin/fig

# Install Go
RUN aptitude install -y \
      mercurial \
      subversion \
      bzr
RUN curl -L https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz | tar -xzf - -C /usr/local
ENV PATH   /usr/local/go/bin:$PATH
ENV GOROOT /usr/local/go
ENV GOPATH /root/gopath
RUN mkdir -p $GOPATH

# Install VIM
RUN hg clone http://hg.debian.org/hg/pkg-vim/vim /opt/vim
RUN cd /opt/vim \
 && hg checkout v7-4-397
RUN aptitude install -y \
      libtcl8.6 \
      libselinux1 \
      libc6 \
      libtinfo5 \
      libacl1 \
      libgpm2 \
      libssl-dev \
      libncurses5-dev
RUN cd /opt/vim \
 && ./configure --with-features=huge --with-compiledby='ryan@rtlong.com' \
 && make \
 && make install

# Set up some environment
ENV HOME /root
ENV DOTFILES_PATH $HOME/dotfiles

# Set up minimum ssh
# ADD ssh/config      /root/.ssh/config
# ADD ssh/known_hosts /root/.ssh/known_hosts
# RUN chown root:root /root/.ssh/* \
#  && chmod 0600      /root/.ssh/*

# Set shell to zsh
RUN usermod -s /usr/bin/zsh root

# Add actual config
ADD . $DOTFILES_PATH
RUN cd $DOTFILES_PATH \
 && git submodule update --init --recursive

RUN $DOTFILES_PATH/link.zsh

# Install vim plugins
RUN $DOTFILES_PATH/setup.sh

ENV SHELL /usr/bin/zsh
WORKDIR /root/
VOLUME ["/root/code"]
CMD ["/usr/bin/zsh"]