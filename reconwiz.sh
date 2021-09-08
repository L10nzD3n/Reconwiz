#!/bin/bash 

domain=$1
RED="\033[1;31m"
RESET="\033[0m"

echo
echo

echo '
$$$$$$$\  $$$$$$$$\  $$$$$$\   $$$$$$\  $$\   $$\ $$\      $$\ $$$$$$\ $$$$$$$$\ 
$$  __$$\ $$  _____|$$  __$$\ $$  __$$\ $$$\  $$ |$$ | $\  $$ |\_$$  _|\____$$  |
$$ |  $$ |$$ |      $$ /  \__|$$ /  $$ |$$$$\ $$ |$$ |$$$\ $$ |  $$ |      $$  / 
$$$$$$$  |$$$$$\    $$ |      $$ |  $$ |$$ $$\$$ |$$ $$ $$\$$ |  $$ |     $$  /  
$$  __$$< $$  __|   $$ |      $$ |  $$ |$$ \$$$$ |$$$$  _$$$$ |  $$ |    $$  /   
$$ |  $$ |$$ |      $$ |  $$\ $$ |  $$ |$$ |\$$$ |$$$  / \$$$ |  $$ |   $$  /    
$$ |  $$ |$$$$$$$$\ \$$$$$$  | $$$$$$  |$$ | \$$ |$$  /   \$$ |$$$$$$\ $$$$$$$$\ 
\__|  \__|\________| \______/  \______/ \__|  \__|\__/     \__|\______|\________|'


info_path=$domain/info
directory_path=$domain/directories
screenshot_path=$domain/screenshots
	
if [ ! -d "$domain" ];then 
	mkdir $domain 
fi

if [ ! -d "$info_path" ];then
	mkdir $info_path
fi

if [ ! -d "$directory_path" ];then
	mkdir $directory_path
fi

if [ ! -d "$screenshot_path" ];then
	mkdir $screenshot_path
fi

echo
echo
echo

read -p "Enter -Pn to disable host discovery from nmap scan:" $Pn

echo

echo -e "${RED} [+] Launching Quick Nmap Scan ...${RESET}"
nmap -T4 -p 80,443 -A $Pn $domain

echo

echo -e "${RED} [+] Launching Full Nmap Scan ...${RESET}"
nmap -T4 -p- -A $Pn $domain | tee $info_path/nmap.txt

echo

echo -e "${RED} [+] Checkin' for Web Vulnerabilities...${RESET}"
nikto -host "http://$domain" | tee "$info_path/nikto.txt"

echo

echo -e "${RED} [+] Launching Dirbuster...${RESET}"
dirbuster -u http://$domain -l /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt -e php | tee -a $directory_path/dirbuster.txt

cat $directory_path/dirbuster.txt | grep "found" | cut -d " " -f 3 > $directory_path/found.txt 
 
echo

echo -e "${RED} [+] Checking What's Alive...${RESET}"

sed -i -e "s/^/$domain/" $directory_path/found.txt 

cat $directory_path/found.txt | httprobe | sed 's/https\?:\/\///' | tee $directory_path/alive.txt 

echo -e "${RED} [+] Taking Dem Screenshotz...${RESET}"
gowitness file -f $directory_path/alive.txt -P $screenshot_path/ -F 2>/dev/null

rm $directory_path/found.txt
 
