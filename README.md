# What is this?

This is a quick and dirty hack for the "Acer Nitro 5" to enable temperature based fan-speed control

This script is not meant to be the "right way of doing this" but rather a low effort way of getting this to work now. Ideally this repository is not needed. But for now works fine.

# Setup

## Dependencies

- Acer-Nitro-5-AN515-58-EC-Control-Linux: https://github.com/Jebaitedneko/Acer-Nitro-5-AN515-58-EC-Control-Linux
- lm-sensors: https://github.com/lm-sensors/lm-sensors

### For installing:

- GNU Make

## Debian/Ubuntu

1) Clone repository:
`git clone https://github.com/e-lisa/nitro-5-fanspeed-hack`

2) Change directories to the repository:
`cd nitro-5-fanspeed-hack`

3) Install lm-sensors and GNU Make:
`sudo apt install lm-sensors make`

4) Configure sensors:
`yes |sudo sensors-detect`

5) Install the service and scripts:
`sudo make`

# Remove

1) Change directories to the repository:
`cd nitro-5-fanspeed-hack`

2) Stop the service:
`systemctl stop nitro5-fan-speed-hack.service`

3) Run the uninstall script:
`make uninstall`
