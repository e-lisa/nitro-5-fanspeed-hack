#!/usr/bin/bash
#
# This file is part of nitro-5-fanspeed-hack
#
# Simple script/hack to control fanspeed based on tempature this should give
# users back control while waiting for kernel support of fanspeed control for
# the "Acer Nitro 5"
#
# This script depends on:
# - https://github.com/Jebaitedneko/Acer-Nitro-5-AN515-58-EC-Control-Linux
# - lm-sensors
#
# We shouldn't need scripts like this in 2024, but here we are
#
# Copyright 2024 Lisa Marie Maginnis


fan_speed=5

echo $fan_speed >/tmp/fanspeed # Write out current fanspeed

is_high() {
    sensors | sed 's/high.*//'|grep -v \(crit |\
        sed -n 's/.*\(\+[0-9+.]*°C\).*/\1/p' |\
        egrep -e '9[0-9].' -e '8[0-9].' -e '7[0-9].'  &>/dev/null
}

is_low() {
    sensors | grep -v 'Composite' | grep -v temp1 |sed 's/high.*//'|\
        grep -v \(crit |\
        sed -n 's/.*\(\+[0-9+.]*°C\).*/\1/p' |\
        egrep '5[0-9].' &>/dev/null
}
nitrosense c $fan_speed &>/dev/null
while [ 1 ]; do
    sleep 1

    is_high

    if [[ $? -eq 0 ]]; then # If tempature is not high"
        is_low
        if [[ $? -ne 0 ]]; then
            if [[ fan_speed -lt 100 ]]; then
                fan_speed=$(($fan_speed+5))
                nitrosense c $fan_speed &>/dev/null
                echo $fan_speed >/tmp/fanspeed # Write out current fanspeed
            fi
        fi
        continue
    fi
    is_low
    if [[ $? -eq 0 ]]; then
        if [[ fan_speed -gt 5 ]]; then
            fan_speed=$(($fan_speed-5))
            nitrosense c $fan_speed &>/dev/null
            echo $fan_speed >/tmp/fanspeed # Writeout current fanspeed
        fi
        continue
    fi
done

