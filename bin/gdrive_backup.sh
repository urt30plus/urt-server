#!/bin/bash
# Requires https://github.com/odeke-em/drive

drive push -verbose -no-prompt "${HOME}/gdrive/backups/$(hostname)"
