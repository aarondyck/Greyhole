#!/bin/bash

set -x
sudo dnf install -y epel-*
sudo crb enable
sudo dnf install -y heimdal-devel chkconfig initscripts lm_sensors-libs mysql-server php-mysqlnd cifs-utils samba-client samba tar wget php perl-Parse-Yapp
sudo mkdir /greyhole
sudo mkdir /greyhole/lz
sudo mkdir /greyhole/drives
sudo mkdir /greyhole/drives/drive01
sudo mkdir /greyhole/drives/drive02
sudo semanage fcontext -a -t samba_share_t "/greyhole/lz(/.*)?"
sudo restorecon -Rv /greyhole/
sudo setsebool -P samba_export_all_rw=1
wget  https://github.com/aarondyck/Greyhole/releases/download/greyhole-rocky_v0.16.00.00/greyhole-rocky_v0.16.00.00.tar.gz
tar -xf greyhole-rocky_v0.16.00.00.tar.gz
cd ./Greyhole-greyhole-rocky_v0.16.00.00

GREYHOLE_INSTALL_DIR=`pwd`
sudo mkdir -p /var/spool/greyhole
sudo mkdir -p /var/spool/greyhole
sudo chmod 777 /var/spool/greyhole
sudo mkdir -p /usr/share/greyhole
sudo install -m 0755 -D -p greyhole /usr/bin
sudo install -m 0755 -D -p greyhole-dfree /usr/bin
sudo install -m 0755 -D -p greyhole-php /usr/bin
sudo install -m 0755 -D -p greyhole-dfree.php /usr/share/greyhole
sudo install -m 0644 -D -p schema-mysql.sql /usr/share/greyhole
sudo install -m 0644 -D -p greyhole.example.conf /usr/share/greyhole
sudo install -m 0644 -D -p greyhole.example.conf /etc/greyhole.conf
sudo install -m 0644 -D -p logrotate.greyhole /etc/logrotate.d/greyhole
sudo install -m 0644 -D -p greyhole.cron.d /etc/cron.d/greyhole
sudo install -m 0755 -D -p greyhole.cron.weekly /etc/cron.weekly/greyhole
sudo install -m 0755 -D -p greyhole.cron.daily /etc/cron.daily/greyhole
sudo cp -r web-app /usr/share/greyhole/web-app
sudo install -m 0755 -D -p scripts-examples/greyhole_file_changed.sh /usr/share/greyhole/scripts-examples
sudo install -m 0755 -D -p scripts-examples/greyhole_idle.sh /usr/share/greyhole/scripts-examples
sudo install -m 0755 -D -p scripts-examples/greyhole_notify_error.sh /usr/share/greyhole/scripts-examples
sudo install -m 0755 -D -p scripts-examples/greyhole_send_fsck_report.sh /usr/share/greyhole/scripts-examples
sudo install -m 0755 -D -p scripts-examples/greyhole_sysadmin_notification.sh /usr/share/greyhole/scripts-examples
sudo install -m 0644 -D -p USAGE /usr/share/greyhole
sudo install -m 0755 -D -p build_vfs.sh /usr/share/greyhole
sudo install -m 0644 -D -p docs/greyhole.1.gz /usr/share/man/man1/
sudo install -m 0644 -D -p docs/greyhole-dfree.1.gz /usr/share/man/man1/
sudo install -m 0644 -D -p docs/greyhole.conf.5.gz /usr/share/man/man5/
LIBDIR=/usr/lib
sudo mkdir "$LIBDIR/greyhole"
sudo cp samba-module/bin/$SMB_VERSION/greyhole-$(uname -m).so "$LIBDIR/greyhole/greyhole-samba${SMB_VERSION//.}.so"
sudo install -m 0644 -D -p greyhole-smb.systemd /usr/lib/systemd/system/greyhole.service
