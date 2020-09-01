#!/bin/zsh

#
# Simple device manager for the iOS simulator
# Select device Boots, builds, and runs the app in the simulator.
#

# Load config (auto-load device)
. ./iOS-simulator.config

# Parse JSON
function parse() {
	awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$1'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${2}p
}

# Select device if UDID wasn't loaded
if [ -z ${UDID} ]; then
	# Print device list
	function deviceList() {
		echo "Devices:"
		xcrun simctl list devices --json | parse name | awk '{print NR ")" $0}'
	}

	# Select device
	deviceList
	echo -n "Device number: "
	read device

	# Get device UDID
	UDID=$(xcrun simctl list devices --json | parse udid $device | tr -d ' ')

	# Save UDID to config (for next run)
	echo "UDID=${UDID}" > "iOS-simulator.config"
fi

# Boot and open the simulator
# xcrun simctl boot "iPhone X"
xcrun simctl boot $UDID
open -a Simulator

# Build and run app
#flutter run