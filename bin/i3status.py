#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import datetime
import json
import time
import subprocess
from decimal import Decimal


DELAY = 5
WIFI = 'wlp3s0'
WARN = '#d79921'
ALARM = '#fb4934'
INFO = '#b8bb26'
BAT = ('\uf244', '\uf244', '\uf243', '\uf243', '\uf242', '\uf242',
       '\uf241', '\uf241', '\uf241', '\uf240', '\uf240')


def run(cmd):
    return subprocess.getoutput(cmd).strip()


def block(name, text, color=None):
    b = {'full_text': text, 'name': name, 'markup': 'none'}
    if color:
        b['color'] = color
    return b


def wireless():
    operstate = os.path.join('/', 'sys', 'class', 'net', WIFI, 'operstate')
    is_online = os.path.isfile(operstate) \
        and open(operstate).read().strip() == 'up'
    symb = '\uf1eb'
    if not is_online:
        return block('wireless', '%s 0%%' % symb, WARN)
    name = run('iwgetid --raw')
    ip = run(
        'ip addr show dev %s |grep inet |grep %s |awk \'{print $2}\''
        % (WIFI, WIFI)
    )
    ip = ip and ip.split('/')[0]
    signal = run(
        'grep %s /proc/net/wireless |awk \'{ print int($3 * 100 / 70) }\''
        % WIFI
    )
    signal = int(signal)
    color = None if signal > 80 else signal > 30 and WARN or ALARM
    return block('wireless', '%s %s%% %s %s' % (symb, signal, name, ip), color)


def storage():
    info = run('/usr/bin/df -P -l / |grep -v Avail |awk \'{print $4, $5}\'')
    size, percent = info.split(' ', 1)
    percent = int(percent[:-1])
    size = '%.1f' % (float(size) / 1024 / 1024)
    color = None if percent < 95 else percent > 98 and ALARM or WARN
    symb = '\uf0a0'
    return block('storage', '%s %sGb' % (symb, size), color)


def volume():
    info = run('amixer -D default get Master |grep dB |awk \'{print $4, $6}\'')
    percent, state = info.replace('[', '').replace(']', '').split(' ')
    value = int(percent[:-1])
    color = state != 'on' and WARN or None
    symb = (state != 'on' or value < 10) and '\uf026' \
        or (value > 60 and '\uf028' or '\uf027')
    return block('volume', '%s %s' % (symb, percent), color)


def processor():
    idle = run('vmstat -w |grep -v procs |grep -v cache |awk \'{print $15}\'')
    load = 100 - int(idle)
    symb = '\uf2db'
    color = None if load < 40 else WARN
    return block('processor', '%s %s%%' % (symb, load), color)


def acpi():
    info = run('acpi -abt')
    info = (x.split(': ') for x in info.split('\n'))
    info = dict((x.split()[0], y) for x, y in info)
    is_online = info.get('Adapter') == 'on-line'
    battery = 'Battery' in info and info.get('Battery').split(', ')[1]
    battery_val = battery and int(battery[:-1]) // 10
    battery_symb = battery_val <= 10 and BAT[battery_val] or BAT[-1]
    battery_color = None if is_online else battery_val < 2 and ALARM or WARN
    temp = 'Thermal' in info and info.get('Thermal').split(' ')[1]
    temp_val = Decimal(temp)
    temp_color = None if temp_val < 65 else temp_val < 75 and WARN or ALARM
    temp_symb = (
        '\uf2ca' if temp_val < 65 else temp_val < 75 and '\uf2c8' or '\uf2c7')
    return (
        block('temp', '%s %s\u2103' % (temp_symb, temp), temp_color),
        block('battery', '%s %s' % (battery_symb, battery), battery_color),
    )


def keyboard():
    kbd = run('xkb-switch')
    prefix = '\uf11c'
    color = None if kbd == 'us' else WARN
    return block('keyboard', '%s %s' % (prefix, kbd), color)


def now():
    dt = datetime.datetime.now().strftime('%d.%m.%Y %H:%M:%S')
    return block('tztime', u'\uf073 ' + dt)


def status_line():
    line = [
        keyboard(),
        storage(),
        wireless(),
        processor(),
        *acpi(),
        volume(),
        now()
    ]
    return line


def main():
    print('{"version":1}')
    print('[')
    print('[],')
    while True:
        print(json.dumps(status_line()) + ',', flush=True)
        time.sleep(DELAY)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(0)
