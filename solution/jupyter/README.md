# reference: https://hub.docker.com/_/ubuntu/
FROM ubuntu:16.04
# Adds metadata to the image as a key value pair example LABEL version="1.0"
LABEL maintainer="Your Name <some_email@domain.com>"
# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
# Create empty directory to attach volume
RUN mkdir ~/GitProjects
# Install Ubuntu packages
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    build-essential \
    curl \
    git-core \
    htop \
    pkg-config \
    unzip \
    unrar \
    tree \
    freetds-dev
# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
# Install Jupyter config
RUN mkdir ~/.ssh && touch ~/.ssh/known_hosts
RUN ssh-keygen -F github.com || ssh-keyscan github.com >> ~/.ssh/known_hosts
RUN git clone https://github.com/bobbywlindsey/dotfiles.git
RUN mkdir ~/.jupyter
RUN cp /dotfiles/jupyter_configs/jupyter_notebook_config.py ~/.jupyter/
RUN rm -rf /dotfiles
# Install Anaconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh
RUN /bin/bash ~/anaconda.sh -b -p /opt/conda
RUN rm ~/anaconda.sh
# Set path to conda
ENV PATH /opt/conda/bin:$PATH
# Update Anaconda
RUN conda update conda && conda update anaconda && conda update --all
# Install Jupyter theme
RUN pip install msgpack jupyterthemes
RUN jt -t grade3
# Install other Python packages
RUN conda install pymssql
RUN pip install SQLAlchemy \
    missingno \
    json_tricks \
    bcolz \
    gensim \
    elasticsearch \
    psycopg2-binary
# Configure access to Jupyter
WORKDIR /root/GitProjects
EXPOSE 8888
CMD jupyter lab --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='data-science'
