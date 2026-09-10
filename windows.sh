#!/usr/bin/bash
prevwindows=0

checkWindows() {
  activeworkspace=$(hyprctl -j activeworkspace)
  windows=$(jq -r '.windows' <<<"$activeworkspace")
  if [[ $windows = 0 ]]; then
    echo "true"
  else
    echo "false"
  fi
  prevwindows=$windows
}

handle() {
  case $1 in
  workspace*) checkWindows ;;
  closewindow*) checkWindows ;;
  openwindow*) checkWindows ;;
  configreloaded*) checkWindows ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
