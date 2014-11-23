FROM ubuntu:latest
MAINTAINER tretkow

# environment variables
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y tmux vim git 

RUN useradd dev && \ 
    echo ALL            ALL = \(ALL\) NOPASSWD: ALL >> /etc/sudoers

RUN git clone https://github.com/tretkow/dotvim.git /home/dev/.vim && ln -s /home/dev/.vim/vimrc /home/dev/.vimrc
RUN git clone https://github.com/tretkow/dotfiles.git /home/dev/.dotfiles && ln -s /home/dev/.dotfiles/tmux.conf /home/dev/.tmux.conf

RUN cd /home/dev/.vim && git submodule update --init --recursive

RUN apt-get install -y build-essential cmake exuberant-ctags python-dev
RUN cd /home/dev/.vim/bundle/YouCompleteMe/ && ./install.sh --clang-complete

RUN apt-get install -y golang
RUN export GOPATH=/home/dev/go && mkdir -p $GOPATH && go get -u github.com/jstemmer/gotags && sudo ln -s $GOPATH/bin/gotags /usr/bin

WORKDIR /home/dev
ENV HOME /home/dev
ENV LC_ALL en_US.UTF-8

RUN chown -R dev:dev $HOME
USER dev


CMD vim

