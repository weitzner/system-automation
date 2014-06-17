System Automation
=================

A repository to hold various daemons to keep your OS X system up to date.
If updates are available, you'l receive an email informing you of what to do.



Credits
-------
* `update_macports.sh` borrows (heavily) from dtrsan's `port-update.sh` (https://github.com/dtrsan/scrapbook/blob/master/bin/port-update.sh)

Instructions
------------
* Move `update_macports.sh` and `send_email.py` to the desired location (*e.g.* `~/bin`)
    * Configure `send_email.py` for your own email address and password. If you're using gmail (or any other email provider that supports two-factor authentication), I recommend using an application-specifc password because it has to be stored in plain text.
    * Configure `update_macports.sh` to point to `send_mail.py` and to your installation of MacPorts
* Move `weitzner.UpdateMacPorts.plist` to `/Library/LaunchDaemons` and feel free to rename the identifier
     `cp weitzner.UpdateMacPorts.plist /Library/LaunchDaemons/$USER.UpdateMacPorts.plist`
    * Update `/Library/LaunchDaemons/$USER.UpdateMacPorts.plist` to point to the path where `update_macports.sh` is located and (optionally) change the label your liking.
* Add the daemon to launchd:
    ` sudo launchctl load -w /Library/LaunchDaemons/$USER.UpdateMacPorts.plist`
