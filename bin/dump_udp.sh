#!/bin/bash

sudo tcpdump -nn -i eth0 -X portrange 27960-27969
