FROM subparticles/android-gradle-java:android29-gradle6.6.1-java11

USER root

# Install python
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# Install cmake
RUN apt-get install -y apt-transport-https ca-certificates gnupg software-properties-common wget
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
RUN apt update \
  && apt install -y cmake

USER user

# Install Android ndk and cmake
RUN yes | sdkmanager --licenses
RUN sdkmanager --update
RUN sdkmanager --install "ndk;22.1.7171670" "cmake;3.18.1" 

