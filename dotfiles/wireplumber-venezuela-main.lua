rule = {
    matches = {
        {
            { "node.name", "equals", "alsa_output.pci-0000_0d_00.1.hdmi-stereo" },
            { "node.name", "equals", "alsa_output.usb-Samson_Technologies_Samson_Meteor_Mic-00.analog-stereo" },
        },
    },
    apply_properties = {
        ["device.disabled"] = true,
    },
}

table.insert(alsa_monitor.rules, rule)
