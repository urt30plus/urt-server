#!/bin/bash

vmstat -a --unit M --timestamp 30 |tee /game/logs/monitor_vm.log
