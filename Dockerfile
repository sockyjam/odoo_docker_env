FROM debian:buster-slim
MAINTAINER SockyJam <sockyjam@126.com>

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
ADD wkhtmltox_0.12.5-1.stretch_amd64.deb /tmp/wkhtmltox_0.12.5-1.stretch_amd64.deb
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            dirmngr \
            fonts-noto-cjk \
            gnupg \
            libssl-dev \
            node-less \
            npm \
            python3-num2words \
            python3-pip \
            python3-phonenumbers \
            python3-pyldap \
            python3-qrcode \
            python3-renderpm \
            python3-setuptools \
            python3-slugify \
            python3-vobject \
            python3-watchdog \
            python3-xlrd \
            python3-xlwt \
            xz-utils \
        && apt-get install -y --no-install-recommends /tmp/wkhtmltox_0.12.5-1.stretch_amd64.deb \
        && rm -rf /var/lib/apt/lists/* /tmp/wkhtmltox_0.12.5-1.stretch_amd64.deb

        #&& curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
        #&& echo '7e35a63f9db14f93ec7feeb0fce76b30c08f2057 wkhtmltox.deb' | sha1sum -c - \


# install latest postgresql-client
RUN set -x; \
        echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
        && export GNUPGHOME="$(mktemp -d)" \
        && repokey='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8' \
        && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
        && gpg --batch --armor --export "${repokey}" > /etc/apt/trusted.gpg.d/pgdg.gpg.asc \
        && gpgconf --kill all \
        && rm -rf "$GNUPGHOME" \
        && apt-get update  \
        && apt-get install -y postgresql-client \
        && rm -rf /var/lib/apt/lists/*

# Install rtlcss (on Debian buster)
RUN set -x; \
    npm install -g rtlcss

RUN apt-get update \
    && apt-get install python3-psycopg2 \
                python3-psutil


RUN pip3 install setuptools wheel
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
RUN npm install -g rtlcss

RUN apt install -y gcc python3-dev

RUN pip3 install \
	         oauthlib \
                 psycopg2-binary \
                 Werkzeug==0.11.15 \
                 reportlab \
                 aliyun-python-sdk-core \
                 aliyun-python-sdk-iot \
                 oss2 \
                 weixin-python==0.5.4 \
                 alipay-sdk-python==3.3.398

# but alipay 2.0.1 is used by now...



ENV ODOO_VERSION 13.0
ARG ODOO_RELEASE=20200121



# Expose Odoo services
EXPOSE 8069 8071



# Set default user when running the container
#USER odoo


