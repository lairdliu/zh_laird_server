#!/bin/sh

GetHwaddr ()
{
    if [ -f /sys/class/net/${1}/address ]; then
        awk '{ print toupper($0) }' < /sys/class/net/${1}/address
    elif [ -d "/sys/class/net/${1}" ]; then
        LC_ALL= LANG= ip -o link show ${1} 2>/dev/null | \
            awk '{ print toupper(gensub(/.*link\/[^ ]* ([[:alnum:]:]*).*/,
                                        "\\1", 1)); }'
    fi
}

GetHwaddr_self ()
{
    if [ -f /opt/uniway/mac/${1}/address ]; then
        awk '{ print toupper($0) }' < /opt/uniway/mac/${1}/address
    fi
}

