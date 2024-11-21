#!/bin/bash

set -euxo pipefail

export WLR_BACKENDS=headless
export WLR_LIBINPUT_NO_DEVICES=1

labwc &

export WAYLAND_DISPLAY=wayland-0
# TODO: Is there some way to detect labwc is ready?
sleep 5
exec wayvnc
