FROM ubuntu
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install build-essential iproute2 git-core -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install vim-nox -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install iputils-ping -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install net-tools -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install iptables -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install zsh curl -y
RUN curl -Lo /usr/bin/shadowenv https://github.com/Shopify/shadowenv/releases/download/2.0.5/shadowenv-ubuntu-18.04
RUN chmod +x /usr/bin/shadowenv
RUN git clone https://github.com/emptymonkey/ptrace_do
RUN make -C /ptrace_do

ADD setup /setup
ADD zshrc /root/.zshrc
ADD Makefile /autons/Makefile
ADD test.c /autons/test.c
RUN make -C /autons
ENTRYPOINT zsh
