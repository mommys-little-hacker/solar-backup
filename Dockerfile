FROM debian:stretch-slim

RUN mkdir -p /opt/solar-backup \
  && mkdir -p /etc/solar-backup \
  && apt-get update \
  && apt-get install -y \
    curl \
    wget \
    openssh-client \
    python3-pip \
  && pip3 install s3cmd \
  && wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list \
  && apt-get update \
  && apt-get install -y \
    postgresql-client-10 \
    mariadb-client \
  && rm -rf /var/lib/apt/lists/

COPY backends /opt/solar-backup/backends
COPY data /opt/solar-backup/data
COPY functions /opt/solar-backup/functions
COPY solar-backup.sh /opt/solar-backup/solar-backup.sh
COPY include/solar-backup.conf /etc/solar-backup/solar-backup.conf

ENTRYPOINT ["/opt/solar-backup/solar-backup", "-m"]
