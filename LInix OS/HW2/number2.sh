#!/bin/bash
DATE=$(date +%d-%m-%Y)
BACKUP_DIR="/home/skillfactory_lab/archive/"
# Creating the backup with archiving:
echo "Creating the backup with archiving..."
sudo tar -zcvpf $BACKUP_DIR/Created_By_AG-$DATE.tar.gz /home/skillfactory_lab/Desktop \
/home/skillfactory_lab/docker /home/skillfactory_lab/Documents /home/skillfactory_lab/PycharmProjects \
/home/skillfactory_lab/data /etc/ssh/sshd_config /etc/xrdp /etc/vsftpd.conf /var/log

# To delete files older than 15 days
find $BACKUP_DIR/* -mtime +15 -exec rm {} \;

# Здесь мой скрипт создаёт архив, сжимает его и помещает в директории /archive, что
# исключает дополнительное перемещение файла командой mv.
# Сам скрипт запускается из директории, где я сохранял все скрипты: ~/.local/bin/
# Tar_Backup_AG_created.png демонстрирует созданный архив. Crontab_file_with_number2.sh.png демонстрирует
# модифицированный cron файл для выполнения резервного копирования каждую пятницу, в 18:30.

# main command:
# tar -zcvpf /[Backup_Location]/[Backup_Filename] /[User_Home_Directory_Location]

