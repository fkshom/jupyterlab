ARG BASE_CONTAINER=jupyter/tensorflow-notebook:8d32a5208ca1
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root 
RUN apt-get update
RUN apt-get install -y libtool libffi-dev ruby ruby-dev make git libzmq3-dev autoconf pkg-config

RUN git clone https://github.com/zeromq/czmq .czmq
WORKDIR /home/jovyan/.czmq
RUN ./autogen.sh && ./configure && make && make install

#RUN jupyter labextension install jupyterlab-plotly@4.8.2
RUN jupyter labextension install jupyterlab-plotly@4.14.3

#RUN jupyter labextension install @jupyter-widgets/jupyterlab-#manager plotlywidget@4.8.2
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager plotlywidget@4.14.3

RUN gem install cztop 
RUN gem install iruby --pre
RUN apt install -y shared-mime-info
RUN gem install rbplotly daru daru-plotly daru-view mimemagic

RUN gem install specific_install
RUN gem specific_install https://github.com/zach-capalbo/iruby-plotly

USER $NB_UID
RUN iruby register --force

WORKDIR $HOME
