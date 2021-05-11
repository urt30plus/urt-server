#!/bin/bash

srcport=${1:-27961}

/game/bin/dump_udp.sh | egrep "IP $(hostname -i).${srcport} > .*: UDP"
