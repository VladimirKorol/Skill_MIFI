#!/bin/bash
# Logging out the script completion:
LOG_FILE=./scriptlog.txt
exec &> >(tee -a "$LOG_FILE")

# 1.  On my system I need to perform chmod +x on every new bash file:
file=./number1.sh
chmod +x $file
chmod +x $LOG_FILE
printf "\n"
echo "Granting +x permissions on the script file and it's log"

# 2. Checking for Linux distro and version:
distro=$(lsb_release -i 2> /dev/null | awk '{print $3}')
version=$(lsb_release -r 2> /dev/null | awk '{print $2}')
echo "Distro name: $distro"
echo "OS Version: $version"

# 3. Checking for Backport repository in the system:
if cat /etc/apt/sources.list | grep "backport"; then
  printf "\n"
  echo "Backport repository is present in the system"
else
  echo "Adding Backport..."
  echo "deb http://archive.ubuntu.com/ubuntu ${version}-backports main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
fi

# 4. Updating and upgrading the APT package manager:
printf "\n"
echo "Updating the OS, please stand by..."
sudo apt-get update
sudo apt-get upgrade

# 5. Install and start Apache server:
printf "\n"
echo "Installing Apache2 server..."
sudo apt install apache2
# check if the service is running:
sudo sysstemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2
# open Chromium with the localhost:80 address to test Apache2 (Important: start this script locally on the server to see the opened Chromium)::
chromium "localhost:80"

# 6. Installing Python3:
printf "\n"
echo "Installing Python3 on the system..."
sudo apt install python3

# 7. Installing and starting SSH:
printf "\n"
echo "Installing SSH server..."
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl stats ssh

# 8. List the home directory of the user;
printf "\n"
echo "The contents of the home directory:"
cd ~/ && ls -l

# 9. Checking if the specific directory contains the .sh files:
printf "\n"
cd ~/.local/bin/
echo "Checking the ~/.local/bin directory for .sh files..."
find . -type f -exec bash -c '
    [[ "$( file -bi "$1" )" == */x-shellscript* ]]' bash {} \; -print

# 10. Purging the contents of the created logfile:
printf "\n"
echo "Purging the scriptlog.txt log file: "
cd ~/.local/bin/
printf "\n"
echo "All files in this directory"
ls -l
dd if=/dev/null > $LOG_FILE
