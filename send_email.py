#!/usr/bin/python

import argparse
from email.mime.text import MIMEText
import smtplib
import sys


class emailer(object):
    def __init__(self, subject, body, dest=None):
        # Sender information
        self._gmail_username = 'YOUR_ADDRESS@gmail.com'
        self._pw = 'APPLICATION-SPECIFIC-PASSWORD'

        self.subject = subject
        self.body = body
        # if no recipient is provided, send it to myself
        self.recipient = dest if dest is not None else self._gmail_username

    def _prepare_msg(self):
        msg = MIMEText(self.body)
        msg['Subject'] = self.subject
        msg['From'] = self._gmail_username
        msg['To'] = self.recipient
        self.msg = msg.as_string()

    def sendmail(self):
        self._prepare_msg()
        session = smtplib.SMTP('smtp.gmail.com', 587)
        session.ehlo()
        session.starttls()
        session.login(self._gmail_username, self._pw)
        session.sendmail(self._gmail_username, self.recipient, self.msg)
        session.quit()


def main(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument('-r', '--recipient',
                        help='The destination email address', type=str)
    parser.add_argument('-s', '--subject',
                        help='The subject of the  email', type=str)
    parser.add_argument('-m', '--message',
                        help='The body of the email', type=str)

    args = parser.parse_args()

    my_emailer = emailer(args.subject, args.message, args.recipient)
    my_emailer.sendmail()

if __name__ == '__main__':
    main(sys.argv)
