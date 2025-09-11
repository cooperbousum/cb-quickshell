#!/bin/bash
# Adjust brightness (works for systems with `brightnessctl` or `ddcutil`)
# Replace with your actual brightness control method

case $1 in
get)
  brightnessctl g | xargs echo # Get current brightness
  ;;
set)
  brightnessctl s $2% >/dev/null # Set brightness (percentage)
  ;;
esac
