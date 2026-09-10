#!/usr/bin/bash
fullHeight() {
  activeworkspace=$(jq -r '.id' <<<"$(hyprctl activeworkspace -j)")
  allwindows=$(hyprctl clients -j | jq --argjson ws "$activeworkspace" '[.[] | select(.workspace.id == $ws)]')
  floatingwindows=$(echo "$allwindows" | jq '[.[] | select(.floating == true)]')
  monitorheight=$(hyprctl monitors -j | jq '.[0].height')
  gapsout=$(hyprctl getoption general:gaps_out -j | jq -r '.custom | split(" ")[1]')

  results=()
  while IFS= read -r window; do
    result=$(echo "$window" | jq '.at[1] + .size[1]')
    results+=($(($result < $monitorheight - $gapsout * 2)))
  done < <(echo "$floatingwindows" | jq -c '.[]')

  allcount=$(echo "$allwindows" | jq 'length')
  floatcount=$(echo "$floatingwindows" | jq 'length')

  if [[ $allcount -ne $floatcount ]] || [[ " ${results[*]} " == *" 0 "* ]]; then
    echo false
  else
    echo true
  fi
}

fullHeight

handle() {
  case $1 in
  workspace*) fullHeight ;;
  closewindow*) fullHeight ;;
  openwindow*) fullHeight ;;
  configreloaded*) fullHeight ;;
  movewindowv2*) fullHeight ;;
  esac
}

touch /home/cooperb/.config/quickshell/tmp/hypr_events

(inotifywait -m -e modify /home/cooperb/.config/quickshell/tmp/hypr_events | while read -r _; do
  fullHeight
done) &

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
