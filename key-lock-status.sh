#!/bin/bash
# key-lock-status
# https://forums.debian.net/viewtopic.php?p=759616
#
#status=$(xset -q | grep Caps | awk '{print $2 $3 $4, $6 $7 $8}')
status=$(xset -q | grep Caps | awk '{print $4}')

if [[ $status == "on" ]]; then
    PANEL="<txt><span weight='Bold' fgcolor='Red'>CapsLock</span></txt>"
else
    PANEL="<txt></txt>"
fi

TOOLTIP="<tool>"
#TOOLTIP+="Caps lock and number lock status"
TOOLTIP+=""
TOOLTIP+="</tool>"
  echo -e "${PANEL}"
  echo -e "${TOOLTIP}"
