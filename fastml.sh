#!/bin/sh

help()
{
    echo -e "A script for Arch Linux distro that get a list of mirrors based on a given ISO country code from Pacman Mirrorlist Generator and rank them by speed\n\n" \
    "Usage: (/path/to/script) [options...]\n\n" \
    "Options:\n" \
    "\t-h, -H, --help\tThis help text\n" \
    "\t-c, -C, --country\tDefine a country by its ISO 2-code" 
    
    exit 0
}

if [ $# == 0 ]; then
    help
fi

if [ "$EUID" -ne 0 ];then
    echo -e "Execute it as root"
    exit 1
fi

while [ "$1" != "" ]; do
    case $1 in
        -c | -C | --country )    shift
                            country="$1"
                            ;;
        -h | -H | --help )       help
                            ;;
    esac
    shift
done

files=$(ls /etc/pacman.d/ -1 | grep -E "mirrorlist(\.backup\.\d+)?" | wc -l)
mirrorlist_url="https://www.archlinux.org/mirrorlist/?country=$country&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on"

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup.$files
curl -s $mirrorlist_url | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors - > mirrorlist
mv mirrorlist /etc/pacman.d/mirrorlist
pacman -Syy

exit 0