#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

log(){ echo -e "${GREEN}[✔]${RESET} $1"; }
warn(){ echo -e "${YELLOW}[!]${RESET} $1"; }
error(){ echo -e "${RED}[✖]${RESET} $1" >&2; exit 1; }

[ "$EUID" -ne 0 ] && error "You must run this script as root."

log "Starting MushM installer."

CROSH="/usr/bin/crosh"
MURK_DIR="/mnt/stateful_partition/murkmod"
MUSHM_URL="https://raw.githubusercontent.com/NonagonWorkshop/Nonamod/main/utils/mushm.sh"
BOOT_SCRIPT="https://raw.githubusercontent.com/NonagonWorkshop/Nonamod/main/utils/bootmsg.sh"
BOOT_DIR="/sbin/chromeos_startup"

mkdir -p "$MURK_DIR/plugins" "$MURK_DIR/pollen" || error "Failed to create directories."

curl -fsSLo "$CROSH" "$MUSHM_URL" || error "Failed to download MushM."
curl -fsSLo "$BOOT_DIR" "$BOOT_SCRIPT" || error "Failed to download boot script."
chmod +x "$BOOT_DIR"

touch /usr/bin/.rwtest 2>/dev/null
if [ ! -f /usr/bin/.rwtest ]; then
    warn "Root filesystem is read-only. Making it writable."
    rm -f /usr/bin/dev_install 2>/dev/null
    /usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification --force || error "Failed to make root filesystem writable."
    echo -e "${YELLOW}System will reboot. After reboot, rerun this script.${RESET}"
    sleep 5
    reboot
    exit
fi
rm -f /usr/bin/.rwtest

log "Installation complete."
echo -e "${YELLOW}Beta and Test Version of NonaMod Made by GamerRyker${RESET}"
sleep 2
