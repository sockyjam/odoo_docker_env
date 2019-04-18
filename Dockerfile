FROM debian:jessie
MAINTAINER SockyJam <sockyjam@126.com>

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get update --fix-missing \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            node-less \
            python-gevent \
            python-pip \
            python-pyinotify \
            python-renderpm \
            python-support \
            git \
            ssh-client \
            postgresql-client \
            python-babel \
            python-greenlet \
            python-markupsafe \
            python-dateutil \
            python-decorator \
            python-docutils \
            python-feedparser \
            python-imaging \
            python-jinja2 \
            python-ldap \
            python-libxslt1 \
            python-lxml \
            python-mako \
            python-mock \
            python-openid \
            python-passlib \
            python-ofxparse \
            python-psutil \
            python-psycopg2 \
            python-pychart \
            python-pydot \
            python-pyparsing \
            python-pypdf \
            python-qrcode \
            python-usb \
            python-serial \
            python-reportlab \
            python-requests \
            python-tz \
            python-vatnumber \
            python-vobject \
            python-werkzeug \
            python-xlwt \
            python-yaml \
            python-six \
            python-xlsxwriter \
            python-wsgiref \
            python-unicodecsv \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb \
        && pip install psycogreen==1.0 \
        && pip install suds-jurko \
        && pip install jcconv \
	&& pip install aliyun-python-sdk-core \ 
	&& pip install aliyun-python-sdk-iot

# Install Odoo


# Expose Odoo services
EXPOSE 8069 8071


# Set default user when running the container
USER odoo

