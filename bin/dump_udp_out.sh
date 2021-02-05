#!/bin/bash

srcport=${1:-27961}

/ssd/game/bin/dump_udp.sh | egrep "IP $(hostname -i).${srcport} > .*: UDP"
