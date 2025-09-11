#!/usr/bin/env bash

cat /sys/class/power_supply/BAT0/current_now /sys/class/power_supply/BAT0/voltage_now | xargs | awk '{printf "%.0f", $1*$2/1e12}'
