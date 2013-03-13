#!/bin/bash

SLEEP_SEC=5
#loops forever outputting a line every SLEEP_SEC secs
while :; do

    BAT_CHGSTATE=$(cat /proc/acpi/battery/BAT0/state | awk '/charging state/ {print $3}') 
    if [[ $BAT_CHGSTATE = discharging ]]; then
        AC_STATUS="ON BATT"
    else
        AC_STATUS="ON AC"
    fi
    POWER_STR="$AC_STATUS $BAT_CHGSTATE"

    #scrotwm bar_print can't handle UTF-8 characters, such as degree symbols
    #CORE0TEMP=$(cat /proc/acpi/thermal_zone/TZS0/temperature | awk '{print $2}')
    #CORE1TEMP=$(cat /proc/acpi/thermal_zone/TZS1/temperature | awk '{print $2}')
    #TEMP_STR="Cpu temp = $CORE0TEMP,$CORE1TEMP"

    if [[ -n $(grep eth0 /proc/net/route) ]]; then
        NET_STR="Wired connection"
    elif [[ -n $(grep wlan0 /proc/net/route) ]]; then
        WLAN_ESSID=$(iwconfig wlan0 | awk -F "\"" '/wlan0/ {print $2}')
        NET_STR="Connected to $WLAN_ESSID"
    else
        NET_STR="No connection"
    fi

    CPULOAD_STR="Load:$(uptime | sed 's/.*://; s/,//g')"

    if [[ -n $(amixer get PCM | grep off) ]]; then
        VOL_STR="Mute"
    else
        VOLUME=$(amixer get PCM | tail -1 | awk '{print $5}' | tr -d '[]') 
        VOL_STR="Vol. $VOLUME"
    fi
    
    eval $(top -b -n 1 | awk 'NR==8,NR==10 {print $12,$9,$10}' | tr '\n' ' ' | awk '{printf "PROC1=%s; PROC1_C=%s; PROC1_M=%s;\
    PROC2=%s; PROC2_C=%s; PROC2_M=%s; PROC3=%s; PROC3_C=%s; PROC3_M=%s", $1,$2,$3,$4,$5,$6,$7,$8,$9};' -)
    PROC_STR="$PROC1: Cpu $PROC1_C% Mem $PROC1_M% :: $PROC2: Cpu $PROC2_C% Mem $PROC2_M% :: $PROC3: Cpu $PROC3_C% Mem $PROC3_M%"

#    eval $(date "+DATE_DAY=%a DATE_MTH=%b DATE_NUM=%d DATE_TM=%R")
#    DATE_STR="$DATE_DAY, $DATE_MTH $DATE_NUM :: $DATE_TM"

#    echo -e "$POWER_STR  |  $CPULOAD_STR  |  $NET_STR  |  $VOL_STR  |  $PROC_STR  |  $DATE_STR"
     echo -e "$POWER_STR  |  $CPULOAD_STR  |  $NET_STR  |  $VOL_STR  |  $PROC_STR"
    sleep $SLEEP_SEC
done
