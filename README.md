# solar-backup
Stupid backup management system.
All it needs is a remote (or local) storage. Currently it supports FTP, SSH and
local file system for handling files.

Currently the following entities can be backed up:
* files (FTP/SSH/local)
* databases (mysqldump/pg_dump)
* cron
* docker containers

## Istallation
```cd /opt
git clone https://github.com/qwertys-ru/solar-backup.git
ln -rs /opt/solar-backup/solar-backup.sh /usr/local/bin/solar-backup
mkdir -p /etc/solar-backup/hooks
cp /opt/data/solar-backup.conf /etc/solar-backup/
```

## Configuration
This utility expects to find global configuration file in:

`/etc/solar-backup/solar-backup.conf`

It follows bash syntax, so if you want to check its validity just run:

`bash -n /etc/solar-backup/solar-backup.conf`

Please note, that `files_backend` MUST be set up even you don't plan to back up
any files, since other backup subsystems (cron, docker, database) rely on it for
file transfer.

Example configuration file can be found in:

`$INSTALLDIR/data/solar-backup.conf`

Most configuration file directives have self descriptive names.

## Usage
`solar-backup [ --make | --list | --version ]`

It is possible to specify custom configuration file using CONFFILE environment
variable:

`CONFFILE="/path/to/file.conf" solar-backup -m`

By defult, this utility assumes to be installed in /opt/solar-backup. You can
override it by using INSTALLDIR environment variable:

`INSTALLDIR=/path/to/dir solar-backup -m`

## License
This piece of software is public domain. Feel free to redistribute it in any
way want.
