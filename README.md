System Automation
=================

A repository to hold various daemons to keep your system up to date.
If updates are available, you'l receive an email informing you of what to do.



Credits
-------
* `update_macports.sh` borrows (heavily) from dtrsan's `port-update.sh` (https://github.com/dtrsan/scrapbook/blob/master/bin/port-update.sh)

Instructions
------------
* Move `update_macports.sh` and `send_email.py` to the desired location (*e.g.* `~/bin`)
* Configure `send_email.py` for your own email address and password. If you're using gmail (or any other email provider that supports two-factor authentication), I recommend using an application-specifc password because it has to be stored in plain text.
* Move `weitzner.UpdateMacPorts.plist` to `/Library/LaunchDaemons` and feel free to rename the identifier
     `cp weitzner.UpdateMacPorts.plist /Library/LaunchDaemons/$USER.UpdateMacPorts.plist`
* Add the daemon to launchd:
    ` sudo launchctl load -w /Library/LaunchDaemons/$USER.UpdateMacPorts.plist`
