#!/bin/bash 

RED="\033[1;31m"
RESET="\033[0m"

echo -e "${RED} [+] Installing pimpmykali...${RESET}"
rm -rf pimpmykali/ | git clone https://github.com/Dewalt-arch/pimpmykali

echo

echo -e "${RED} [+]  Launching pimpmykali...${RESET}"
cd pimpmykali/ 
./pimpmykali.sh

echo

echo -e "${RED} [+] Updating System...${RESET}"
apt update
apt upgrade

echo

echo -e "${RED} [+] Wgetting go installer...${RESET}"
wget 'https://golang.org/dl/go1.17.1.linux-amd64.tar.gz'

echo

echo -e "${RED} [+] Installing go-lang...${RESET}"
rm -rf /usr/local/go 
tar -C '/usr/local' -xzf 'go11.17.1.linux-amd64.tar.gz'

echo

echo -e "${RED} [+] Installing httprobe...${RESET}"
go get -u github.com/tomnomnom/httprobe

echo

echo -e "${RED} [+] Installing gowitness...${RESET}"
go get -u github.com/sensepost/gowitness

echo

echo -e "${RED} [+] Requirements Satisfied!!!...${RESET}"

