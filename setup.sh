#!/bin/bash
# Install tha needs

YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'
PROFILE="$HOME/.bashrc"

function suc() {
    echo -e "${GREEN}[+] $1${NC}"
}

function err() {
    echo -e "${RED}[-] $1${NC}"
}

set -eo pipefail

sudo apt update -yqq && sudo apt upgrade -yqq

echo -e "${YELLOW}[+] Installing Common${NC}"
sudo apt install build-essential gcc unzip curl software-properties-common -y &> /dev/null && suc "Installed Common" || err "Could not install Common"

echo -e "${YELLOW}[+] Installing libfuse2${NC}"
sudo apt install libfuse2 -y &> /dev/null && suc "Installed libfuse2" || err "Could not install libfuse2"

echo -e "${YELLOW}[+] Installing ca-certificates${NC}"
sudo apt install ca-certificates -y &> /dev/null && suc "Installed ca-certificates" || err "Could not install ca-certificates"

echo -e "${YELLOW}[+] Installing git${NC}"
sudo apt install git -y &> /dev/null && suc "Installed git" || err "Could not install git"

echo -e "${YELLOW}[+] Installing bun${NC}"
curl -fsSL https://bun.sh/install | bash &> /dev/null && suc "Installed bun" || err "Could not install bun"

# Remove BUN from rc file.
sed -i '/^# bun/d' "$PROFILE"
sed -i '/^export BUN_INSTALL=.*$/d' "$PROFILE"
sed -i '/^export PATH=\$BUN_INSTALL\/bin:\$PATH$/d' "$PROFILE"

echo -e "${YELLOW}[+] Installing atuin${NC}"
curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash &> /dev/null && suc "Installed atuin" || err "Could not install atuin"

echo -e "${YELLOW}[+] Installing docker${NC}"
curl -fsSL https://get.docker.com | bash &> /dev/null && suc "Installed docker" || err "Could not install docker"