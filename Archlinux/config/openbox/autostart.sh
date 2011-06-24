#!/bin/bash

# FÜr ein besseres Aussehen der Programme
#gnome-settings-daemon &
#xfce4-settings-manager &

# Dateimanager laden
#nautilus --no-desktop &
#thunar --daemon &

# Anzeige des Panels
tint2 &

# Bildschirmhintergrund laden
nitrogen --restore &

## Comp-Mgr
#cairo-compmgr &

## Energieverwaltung
#gnome-power-manager &
xfce4-power-manager &

## Start Conky after a slight delay
(sleep 3s && conky -q)  &
#conky -c .conkyrcline -q &

# Touchpad ausschalten
synclient touchpadoff=1 &

## Launch network manager applet
#nm-applet &
wicd-gtk &

## Guake starten
#(sleep 4s && guake) &

## Dropbox starten
(sleep 29s && dropbox start -i) &

## Magneto
#magneto --startup-delay=30 &
#(sleep 30s && mintupdate-launcher) &

## Lautstärkeregler
#gnome-volume-control-applet &
volumeicon &
#obmixer &

## Pino für Telecomix
#torify pino

# Notizzettel
#xfce4-notes &
gnote &

# Clipboard
#xfce4-clipman &

