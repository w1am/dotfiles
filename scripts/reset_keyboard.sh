#!/bin/bash

# https://askubuntu.com/questions/1231074/ubuntu-20-04-bluetooth-not-working/1238076#1238076

sudo rmmod btusb
sudo modprobe btusb
