ARG CUDA_VERSION=11.1
ARG OS_VERSION=18.04

FROM nvcr.io/nvidia/tensorrt:21.07-py3
#FROM nvcr.io/nvidia/pytorch:21.09-py3
LABEL maintainer="NVIDIA CORPORATION"

#ENV TRT_VERSION 7.2.3.4
SHELL ["/bin/bash", "-c"]

# Setup user account
ARG uid=1000
ARG gid=1000
RUN groupadd -r -f -g ${gid} qmuser && useradd -o -r -u ${uid} -g ${gid} -ms /bin/bash qmuser
RUN usermod -aG sudo qmuser
RUN echo 'qmuser:qmuser' | chpasswd
#RUN mkdir -p /qml && chown qmuser /qml

ENV TZ=Asia/Dubai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update

# Install requried libraries
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    wget \
    zlib1g-dev \
    git \
    pkg-config \
    sudo \
    ssh \
    libssl-dev \
    pbzip2 \
    pv \
    bzip2 \
    unzip \
    devscripts \
    lintian \
    fakeroot \
    dh-make \
    build-essential


# Install python3
RUN apt-get install -y --no-install-recommends \
      python3 \
      python3-pip \
      python3-dev \
      python3-wheel &&\
    cd /usr/local/bin &&\
    ln -s /usr/bin/python3 python
#    ln -s /usr/bin/pip3 pip;

# Install PyPI packages
RUN pip3 install --upgrade pip
RUN pip3 install setuptools>=41.0.0

# Install Cmake
RUN cd /tmp && \
    wget https://github.com/Kitware/CMake/releases/download/v3.20.1/cmake-3.20.1-Linux-x86_64.sh && \
    chmod +x cmake-3.20.1-Linux-x86_64.sh && \
    ./cmake-3.20.1-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license && \
    rm ./cmake-3.20.1-Linux-x86_64.sh

USER root
# Jupyter
RUN pip  install -U  pandas jupyter ipywidgets scikit-learn matplotlib  ipython  ipykernel
# Set working dir

#RUN mkdir ~/.jupyter/
RUN python3 -m pip install ipykernel 
RUN python3 -m pip install networkx 
RUN python3 -m pip install qiskit_aer
RUN python3 -m pip install qiskit_optimization
RUN python3 -m pip install pylatexenc
RUN python3 -m pip install qiskit-ibmq-provider
RUN python3 -m ipykernel install --user 
RUN python3 -m ipykernel.kernelspec
RUN python3 -m pip install qiskit-ibmq-provider
RUN jupyter nbextension enable --py widgetsnbextension 
USER qmuser 
RUN jupyter notebook --generate-config 

USER qmuser
#RUN add jupyter_notebook_config.py
COPY jupyter_notebook_config.py /home/qmuser/.jupyter/jupyter_notebook_config.py
COPY run_jupyter.sh /home/qmuser/
WORKDIR "/" 
USER root
RUN chmod +x /home/qmuser/run_jupyter.sh

USER qmuser
WORKDIR /home/qmuser
RUN git clone https://github.com/PaddlePaddle/Quantum.git
RUN git clone https://github.com/theerfan/Q/
RUN git clone https://github.com/DavitKhach/quantum-algorithms-tutorials.git
RUN git clone https://github.com/mit-han-lab/torchquantum.git
RUN git clone https://github.com/walid-mk/VQE.git
RUN git clone https://github.com/MyEntangled/Quantum-Autoencoders.git


USER root
RUN chown qmuser /home/qmuser/
RUN chown -R qmuser:qmuser /home/qmuser/

USER qmuser
WORKDIR /home/qmuser
RUN ["/bin/bash"]
CMD ["/bin/bash", "-c", "/app/run_jupyter.sh"]
EXPOSE 8097 7842
