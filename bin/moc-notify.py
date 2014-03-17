#!/usr/bin/env python

import os
import subprocess
import tempfile
import time


DIVIDER = ' - '

TITLE_FILE = os.path.join(tempfile.gettempdir(), 'moc-notify.tmp')


def main():
    cmd = ['mocp', '-Q', '%title']
    notify = ['notify-send', '-i', 'emblem-sound', '-t', '7000']

    if not os.path.exists(TITLE_FILE):
        subprocess.call(['touch', TITLE_FILE])

    while True:
        status, output = subprocess.getstatusoutput(' '.join(cmd))
        if status == 0:
            output = output.strip()
            with open(TITLE_FILE, 'r') as f:
                last_title = f.read().strip()
            if last_title != output:
                subprocess.call(notify + ['%s' % output.replace(DIVIDER, '\n')])
                with open(TITLE_FILE, 'w') as f:
                    f.write(output)
        time.sleep(10)


if __name__ == '__main__':
    main()
