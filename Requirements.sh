#!/bin/bash 

RED="\033[1;31m"
RESET="\033[0m"

echo -e "${RED} [+] Installing pimpmykali...${RESET}"
rm -rf pimpmykali/ | git clone https://github.com/Dewalt-arch/pimpmykali

echo -e "${RED} [+]  Launching pimpmykali...${RESET}"
cd pimpmykali/ 
./pimpmykali.sh

echo -e "${RED} [+] Updating System...${RESET}"
apt update
apt upgrade

echo -e "${RED} [+] Installing httprobe...${RESET}"
go get -u github.com/tomnomnom/httprobe

echo -e "${RED} [+] Installing gowitness...${RESET}"
go get -u github.com/sensepost/gowitness

echo -e "${RED} [+] Requirements Satisfied!!!...${RESET}"

