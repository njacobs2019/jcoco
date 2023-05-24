FROM ubuntu:16.04

# Update Ubuntu
RUN apt-get update && apt-get upgrade -y

# Install dependencies
RUN apt-get install -y unzip apt-utils git make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

# Install Pyenv
RUN curl https://pyenv.run | bash

# Modify the shell configuration file
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Set environment variables for pyenv
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Compile Python and set as global interpreter
RUN pyenv install 3.2.6 && pyenv global 3.2.6

# Install JDK
RUN apt-get install openjdk-8-jdk -y

# Install JCoCo
RUN mkdir /bin/jcoco
COPY coco /bin/jcoco/coco
RUN chmod +x /bin/jcoco/coco
COPY JCoCo.jar /bin/jcoco/JCoCo.jar
RUN echo 'export PATH="$PATH:/bin/jcoco"' >> ~/.bashrc

# Copy helper files into /home
COPY disassembler.py /home/disassembler.py
COPY addtwo.py /home/addtwo.py
