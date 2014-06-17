#!/bin/bash

if [ $(/usr/bin/id -u) -ne 0 ]; then
    echo "Must be run as super-user root!"
    exit 1
fi

# Edit this to point to "send_email.py"
EMAIL="/path/to/send_email.py"
if [ ! -f $EMAIL ]; then
    echo "\"$EMAIL\" not found! Check paths."
    exit 1
fi

# Edit this to point to your MacPorts installation
# This can be found by executing "which port"
PORT="/opt/local/bin/port"
if [ ! -f $PORT ]; then
    echo "\"$PORT\" not found! Check paths."
    exit 1
fi

TMPSELFUPDATE=$(mktemp /tmp/macports.selfupdate.XXX)
TMPOUTDATED=$(mktemp /tmp/macports.outdated.XXX)

$PORT selfupdate &> $TMPSELFUPDATE
echo "" >> $TMPSELFUPDATE
$PORT echo outdated &> $TMPOUTDATED

INSTALLED_VERSION=$(grep "^MacPorts base version .* installed,$" $TMPSELFUPDATE | cut -d' ' -f4)
DOWNLOADED_VERSION=$(grep "^MacPorts base version .* downloaded.$" $TMPSELFUPDATE | cut -d' ' -f4)

if [ -s $TMPOUTDATED ]; then
    $EMAIL -s "New macports updates available" -m "`cat $TMPSELFUPDATE $TMPOUTDATED`"
elif [ $INSTALLED_VERSION != $DOWNLOADED_VERSION ]; then
    $EMAIL -s "MacPorts base updated" -m "`cat $TMPSELFUPDATE`"
fi

rm -f $TMPSELFUPDATE
rm -f $TMPOUTDATED
