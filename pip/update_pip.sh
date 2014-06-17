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

# Edit this to point to your pip installation
# This can be found by executing "which pip"
PIP="/usr/local/bin/pip"
if [ ! -f $PIP ]; then
    echo "\"$PIP\" not found! Check paths."
    exit 1
fi

TMPOUTDATED=$(mktemp /tmp/pip.outdated.XXX)

$PIP list --outdated | grep -v bonjour-py &> TMPOUTDATED

if [ -s $TMPOUTDATED ]; then
    $EMAIL -s "New pip updates available" -m "`cat $TMPOUTDATED`"
fi

rm -f $TMPOUTDATED
