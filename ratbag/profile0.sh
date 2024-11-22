#!/bin/bash

# set the device name 
device=$(ratbagctl list | grep -E 'Logitech G305' | awk -F: '{print $2}' | awk '{$1=$1};1')

# Set the profile (0 is default)
ratbagctl "$device" profile active set 0 --nocommit

# Set the DPI
ratbagctl "$device" dpi set 800 --nocommit

# Set the polling rate
ratbagctl "$device" rate set 250 --nocommit

# Reset the button mappings
ratbagctl "$device" button 0 action set button 1 --nocommit
ratbagctl "$device" button 1 action set button 2 --nocommit
ratbagctl "$device" button 2 action set button 3 --nocommit
ratbagctl "$device" button 3 action set button 4 --nocommit
ratbagctl "$device" button 4 action set button 5 --nocommit
ratbagctl "$device" button 5 action set macro KEY_ESC

echo "Profile set for $device"

