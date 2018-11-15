conf_file_global="/etc/solar-backup/solar-backup.conf"
conf_file_user="${HOME}/.solar-backup"
conf_file_default="${app_dir}/include/solar-backup.conf"

my_pid=$$
key=`echo $UID $@ | md5sum | cut -d' ' -f1`
lockfile="/tmp/solar-backup.${key}.lock"

hooks_dir="/etc/solar-backup/hooks/"

tmpdir="/tmp"
cron_tmp_dir="${tmpdir}/crontab.bak"

date_suffix=`date +%Y%m%d`
