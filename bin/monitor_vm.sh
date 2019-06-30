#!/bin/bash

interval=${1:-10}

vmstat -a --unit M --timestamp ${interval} |tee /game/logs/monitor_vm.log
