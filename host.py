import socket
import sys
import re

def help() -> None:
    raise NotImplementedError

def main() -> None:
    addr = ''
    ip = ''

    for i in range(len(sys.argv)):
        if sys.argv[i] in ('-i', '-I', '--ip') and \
        re.match(r"^[0-2]?[0-9]?[1-9](\.[0-2]?[0-9]?[0-9]){3}$", sys.argv[i + 1]):
            ip = sys.argv[i + 1]

        elif sys.argv[i] in ('-a', '-A', '--addr') and \
        re.match(r"^www(\.[A-z][A-z\d]+)+$", sys.argv[i + 1]):
            addr = sys.argv[i + 1]
    
    if addr == ip or (addr != '' and ip != ''):
        exit(1)
    
    elif addr == '':
        raise NotImplementedError

    elif ip == '':
        print('IP address from {}: {}'.format(addr, socket.gethostbyname(addr)))

if __name__ == '__main__':
    try:
        main()

    except KeyboardInterrupt:
        exit()