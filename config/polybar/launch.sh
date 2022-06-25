#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
polybar i3bar 2>&1 | tee -a /tmp/polybar1.log & disown
echo "Bar launched..."
