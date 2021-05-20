# ESC TH connectors: Jupyter Environment Dockerfile
# Author: Anton Kutepov (@aw350m33)
# License: GPL-3.0

FROM codercom/code-server:3.10.1

LABEL maintainer="Anton Kutepov (@aw350m33)"
LABEL description="Dockerfile with ESC Threat Hunting Connectors."

ARG NB_USER
ENV NB_USER coder
ENV HOME /home/${NB_USER}
ENV PATH "$HOME/.local/bin:$PATH"

USER root

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		curl \
		python3 \
		python3-pip \
		git && \
	pip3 install --upgrade pip && \
	pip3 install rise && \
	curl https://sh.rustup.rs -sSF | sh && \
	pip3 install -e 'git+https://github.com/aw350m33d/msticpy.git@mpsiem_data_provider#egg=msticpy[all]' && \
	git clone -b pt_backends https://github.com/aw350m33d/sigma.git

RUN chown ${NB_USER} /usr/local/share/jupyter/kernels/python3/kernel.json \
    && chown -R ${NB_USER}:${NB_USER} ${HOME} ${JUPYTER_DIR}

USER ${NB_USER}