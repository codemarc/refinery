FROM debian:jessie
MAINTAINER Marc J. Greenberg <codemarc@gmail.com>

# Get some Java
RUN \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java7-installer oracle-java7-set-default  && \
    apt-get install -y curl && \
    rm -rf /var/cache/oracle-jdk7-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

# grab the latest released open refine
RUN \
    openrefine=$(curl -s https://github.com/OpenRefine/OpenRefine/releases |grep -A2 "release-downloads" |\
    grep -Eoi '<a [^>]+>' |grep -Eo 'href="[^\"]+"' |head -1 |sed 's/\"//g' |cut -d'=' -f2) && \
    echo grabbing  https://github.com$openrefine  &&\
    curl -L https://github.com$openrefine  | tar zx && \
    mv openrefine* refine  
    
# update the config at build time    
COPY refine.ini refine/refine.ini          
    
EXPOSE 3333

# define default command
CMD "/refine/refine"   