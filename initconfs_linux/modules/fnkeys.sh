#! /usr/bin/env bash
# Makes Fn keys on MacBooks work like Fn keys, not multimedia/brightness controls
# For current session
echo "2" | sudo tee /sys/module/hid_apple/parameters/fnmode > /dev/null

# Permanent change

echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf > /dev/null
sudo update-initramfs -u -k all
