FROM opensuse:leap
MAINTAINER Ingo Müller <ingo.mueller@inf.ethz.ch>
ENV container docker

# Install everything that is needed to run HANA including installer
RUN zypper -n ref && \
    zypper -n up --skip-interactive --no-recommends && \
    zypper -n install -l --no-recommends \
        hostname \
        libltdl7 \
        ncurses-utils \
        numactl \
        python-pyOpenSSL \
        sudo && \
    zypper clean && \
    rm -rf /var/cache/zypp/*

# Install what is needed to dockerize HANA processes
RUN zypper -n ref && \
    zypper -n up --skip-interactive --no-recommends && \
    zypper -n install -l --no-recommends \
        gcc \
        libcap-devel \
        python-devel \
        python-pip && \
    pip install --upgrade pip && \
    pip install \
        python-prctl \
        psutil \
        setproctitle && \
    zypper -n remove --clean-deps \
        gcc \
        libcap-devel \
        python-devel && \
    zypper clean && \
    rm -rf /var/cache/zypp/* \
    rm -rf /root/.cache/

COPY assets/start.sh /opt/start-hxe.sh
COPY assets/angelize.py /opt/angelize.py
COPY assets/install.sh /opt/install.sh

EXPOSE 4390 8090 39013 39015 39018 59013 59014

CMD ["/opt/install.sh"]
