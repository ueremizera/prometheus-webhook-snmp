FROM  python:3.7.3-alpine3.9
MAINTAINER Uere Mizera "ueremizera@gmail.com"

COPY . /app
WORKDIR /app
RUN apk add --no-cache python3-dev \
    && apk add --virtual build-dependencies --no-cache libstdc++ g++ \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip3 install -r requirements.txt
RUN apk del build-dependencies
RUN chmod 644 prometheus-webhook-snmp
CMD python3 prometheus-webhook-snmp --snmp-host=$SNMP_HOST --debug run --metrics