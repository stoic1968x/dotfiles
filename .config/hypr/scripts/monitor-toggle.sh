#!/bin/bash

if hyprctl monitors | grep -q "DP-1"; then
    hyprctl keyword monitor "DP-1, disable"
else
    hyprctl keyword monitor "DP-1,1920x1080@240,1920x0,1.0,transform,3"
fi