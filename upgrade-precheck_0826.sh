#!/bin/bash
#Upgrade pre-check script - August 26, 2021
echo " "
RED=`tput setaf 1`
WHITE=`tput setaf 7`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
NC=`tput sgr0`
echo "${GREEN}Starting Upgrade Pre-check..."
echo " "
echo "${WHITE}Checking for free disk space..."
df -h | egrep -v "overlay|shm"
echo "${GREEN}Please verify disk space above - ${RED}ensure that /var has at least 15GB free - if not please remove un-used docker images to clear enough space"
echo "${WHITE}***************************"
echo " "
echo "${GREEN}Reclaimable space list below - By deleting un-used docker images${WHITE}"
sudo docker system df
echo "${GREEN}To reclaim space from un-used docker images above you need to confirm the previous version of Turbonomic images installed"
echo "Run the command ${WHITE}'sudo docker images | grep turbonomic/auth'${GREEN} to find the previous versions"
echo "Run the command ${WHITE}'for i in \`sudo docker images | grep 7.22.0 | awk '{print $3}'\`; do sudo docker rmi \$i;done'${GREEN} replacing ${WHITE}'7.22.0'${GREEN} with the old previous versions of the docker images installed to be removed to clear up the required disk space"
echo "${WHITE}***************************"
echo " "
read -p "${GREEN}Are you using a proxy to connect to the internet on this Turbonomic instance (y/n)? " CONT
if [[ "$CONT" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    read -p "${WHITE}What is the proxy name or IP and port you use?....example https://proxy.server.com:8080 " P_NAME_PORT
    echo " "
    echo "${WHITE}Checking endpoints for ONLINE upgrade ONLY using proxy provided..."
    if [[ $(curl --proxy $P_NAME_PORT https://index.docker.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached index.docker.io"; else echo "${RED}CANNOT REACH index.docker.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT auth.docker.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached auth.docker.io"; else echo "${RED}CANNOT REACH auth.docker.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://registry-1.docker.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached registry-1.docker.io"; else echo "${RED}CANNOT REACH registry-1.docker.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT production.cloudflare.docker.com --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then  echo "${GREEN}SUCCESSFULLY reached production.cloudflare.docker.com"; else echo "${RED}CANNOT REACH production.cloudflare.docker.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://raw.githubusercontent.com --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached raw.githubusercontent.com"; else echo "${RED}CANNOT REACH raw.githubusercontent.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://github.com --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached github.com"; else echo "${RED}CANNOT REACH github.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://download.vmturbo.com/appliance/download/updates/8.2.0/onlineUpgrade.sh --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached download.vmturbo.com"; else echo "${RED}CANNOT REACH download.vmturbo.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://yum.mariadb.org --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://yum.mariadb.org"; else echo "${RED}CANNOT REACH https://yum.mariadb.org - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://packagecloud.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://packagecloud.io"; else echo "${RED}CANNOT REACH https://packagecloud.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://download.postgresql.org --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://download.postgresql.org"; else echo "${RED}CANNOT REACH https://download.postgresql.org - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl --proxy $P_NAME_PORT https://yum.postgresql.org --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://yum.postgresql.org"; else echo "${RED}CANNOT REACH https://yum.postgresql.org - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    echo "${WHITE}****************************"
else
    echo "${WHITE}Checking endpoints for ONLINE upgrade ONLY..."
    if [[ $(curl https://index.docker.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached index.docker.io"; else echo "${RED}CANNOT REACH index.docker.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl auth.docker.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached auth.docker.io"; else echo "${RED}CANNOT REACH auth.docker.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://registry-1.docker.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached registry-1.docker.io"; else echo "${RED}CANNOT REACH registry-1.docker.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl production.cloudflare.docker.com --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached production.cloudflare.docker.com"; else echo "${RED}CANNOT REACH production.cloudflare.docker.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://raw.githubusercontent.com --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached raw.githubusercontent.com"; else echo "${RED}CANNOT REACH raw.githubusercontent.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://github.com --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached github.com"; else echo "${RED}CANNOT REACH github.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://download.vmturbo.com/appliance/download/updates/8.2.0/onlineUpgrade.sh --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached download.vmturbo.com"; else echo "${RED}CANNOT REACH download.vmturbo.com - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://yum.mariadb.org --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://yum.mariadb.org"; else echo "${RED}CANNOT REACH https://yum.mariadb.org - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://packagecloud.io --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://packagecloud.io"; else echo "${RED}CANNOT REACH https://packagecloud.io - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://download.postgresql.org --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://download.postgresql.org"; else echo "${RED}CANNOT REACH https://download.postgresql.org - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    if [[ $(curl https://yum.postgresql.org --max-time 30 -s -o /dev/null -w "%{http_code}") != @(000|407|502) ]]; then echo "${GREEN}SUCCESSFULLY reached https://yum.postgresql.org"; else echo "${RED}CANNOT REACH https://yum.postgresql.org - DO NOT PROCEED WITH ONLINE UPGRADE UNTIL THIS IS RESOLVED"; fi
    echo "${WHITE}****************************"
fi

echo " "
echo "Checking MariaDB status..."
echo "${GREEN}Checking if the MariaDB service is running...${WHITE}"
MSTATUS="$(systemctl is-active mariadb)"
if [ "${MSTATUS}" = "active" ]; then
    echo "MariaDB service is running"
    echo "${GREEN}Checking MariaDB version${WHITE}"
    systemctl list-units --all -t service --full --no-legend "mariadb.service"
    echo "If the version of MariaDB is below version 10.5.9 you will also need to upgrade it post Turbonomic upgrade following the steps in the install guide"
elif [ "${MSTATUS}" = "unknown" ]; then
    echo "MariaDB service is not installed, precheck skipped"
else 
    echo "${RED}MariaDB service is not running....please resolve before upgrading"  
fi
#sudo systemctl status mariadb | grep Active
echo "${GREEN}Checking if the Kubernetes service is running...${WHITE}"
CSTATUS="$(systemctl is-active kubelet)"
if [ "${CSTATUS}" = "active" ]; then
    echo "Kubernetes service is running..."
else 
    echo "${RED}Kubernetes service is not running....please resolve before upgrading"  
fi
#sudo systemctl status kubelet | grep Active
echo "${GREEN}Please ensure the services above are running, ${RED}if they are not active (running) please resolve before proceeding"
echo "${WHITE}****************************"
echo " "
echo "Checking for expired Kubernetes certificates..."
echo "${GREEN}Checking all certs now...${WHITE}"
kubeVersion=$(/usr/local/bin/kubectl version | awk '{print $4}' | head -1 | awk -F: '{print $2}' | sed 's/"//g' | sed 's/,//g')
if [ $kubeVersion -ge 20 ]
then
    sudo /usr/local/bin/kubeadm certs check-expiration
else
    sudo /usr/local/bin/kubeadm alpha certs check-expiration
fi
echo "${GREEN}Please validate the EXPIRES dates above, ${RED}if the EXPIRES dates listed above is before current date please run the script kubeNodeCertUpdate.sh in /opt/local/bin to renew the expired certs before upgrading"
echo "${WHITE}*****************************"
echo " "
echo "Checking if root password is expired or set to expire..."
echo "${GREEN}root account details below${WHITE}"
sudo chage -l root
echo "${GREEN}Please validate the expiry dates above, ${RED}if expired or not set please set/reset the password before proceeding"
echo "${WHITE}*****************************"
echo " "
echo "${GREEN}Checking if NTP is enabled for timesync...${WHITE}"
timedatectl | grep "NTP enabled"
echo "${GREEN}Checking if NTP is synchronized for timesync...${WHITE}"
timedatectl | grep "NTP sync"
echo "${GREEN}Checking if Chronyd is running for NTP timesync...${WHITE}"
sudo systemctl status chronyd | grep Active
echo "${GREEN}Checking list of NTP servers being used for timesync (if enabled and running)...${WHITE}"
cat /etc/chrony.conf | grep server
echo "${GREEN}Current date, time and timezone configured (default is UTC time)...${WHITE}"
date
echo "${GREEN}Please validate NTP, TIME and DATE configuration above if it is required, ${RED}if not enabled or correct and it is required please resolve by reviewing the Install Guide for steps to Sync Time"
echo "${WHITE}*****************************"
echo " "
echo "${GREEN}Checking for any Turbonomic pods not ready and running...${WHITE}"
if [ -f "/opt/turbonomic/kubernetes/yaml/persistent-volumes/local-storage-pv.yaml" ]; then
    gluster_enabled=false
    kubectl get pod -n turbonomic | grep -Pv '\s+([1-9]+)\/\1\s+' | grep -v "NAME"
else
    gluster_enabled=true
    kubectl get pod -n turbonomic | grep -Pv '\s+([1-9]+)\/\1\s+' | grep -v "NAME"
    kubectl get pod -n default | grep -Pv '\s+([1-9]+)\/\1\s+' | grep -v "NAME"
fi
echo "${GREEN}Please resolve issues with the pods listed above (if any), ${RED}if you cannot resolve on your own **please contact support**"
echo "${WHITE}*****************************"
echo " "
echo "${GREEN}Please take time to review and resolve any issues above before proceeding with the upgrade, ${RED}if you cannot resolve **please contact support**"
echo " "
echo "${GREEN}End of Upgrade Pre-Check${WHITE}"
