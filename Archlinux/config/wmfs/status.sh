#!/bin/sh
#
#
	## Couleurs ##
rouge="\\#FF000B\\" 
vert="\\#1CB500\\" 
jaune="\\#FFF23D\\" 
bleu="\\#4599F8\\" 
orange="\\#FF6600\\" 
rose="\\#FF53B5\\"
camel="\\#FFA500\\"
cyan="\\#00F3FF\\"
normal="\\#D9D9D9\\" 
#
#
	## Heure ##
_hour () {
hour=$(date '+%Hh %Mm')
hour="$vert [ H : $normal$hour$vert ]"
}
#
#
	## Date ##
_dat () {
dat_s=$(date '+%a %d/%m/%y')
dat_l=$(date '+%A %d %b %Y')
dat="$orange [ D : $normal$dat_s$orange ]"
}
#
#
	## Uptime ##
_uptim () {
uptim=$(cut -d'.' -f1 /proc/uptime)
mins=$((${uptim}/60%60))
hours=$((${uptim}/3600%24))
days=$((${uptim}/86400))
uptim="${mins}m"
if [ "${hours}" -ne "0" ]; then
uptim="${hours}h ${uptim}"
fi
if [ "${days}" -ne "0" ]; then
uptim="${days}d ${uptim}"
fi
uptim="$jaune [ U : $normal$uptim$jaune ]"
}
#
#
	## Ram ##
_ram () {
mem_u=$(free -mto | grep Mem | awk '{ print $3 }')
mem_t=$(free -mto | grep Mem | awk '{ print $2 }')
ram="$bleu [ R : $normal$mem_u M / $mem_t M$bleu ]"
}
#
#
	## Hdd ##
_hdd () {
hdd_f=$(df -h / | grep "/dev/" | awk '{print $3}')
hdd_t=$(df -h / | grep "/dev/" | awk '{print $2}')
hdd="$camel [ H : $normal$hdd_f / $hdd_t$camel ]"
}
#
#
	## Températures ##
_temp () {
cpu_t=$(sensors | grep "CPU T" | awk {'print $3'})
mb_t=$(sensors | grep "MB T" | awk {'print $3'})
gpu_t=$(nvidia-settings -t -q GPUCoreTemp)
temp="$vert [ T : $normal$cpu_t $mb_t +$gpu_t°C$vert ]"
}
#
#
	## Musique ##
_mcp () {
if [ -n $(mpc current) ]; then
	mus="off "
	mcp="$rose [ M : $normal$mus$rose ]"
else
	if [ $(mpc current | wc -m) -gt "25" ]; then
		mus=$(mpc current |  cut -b 1-25)
		mcp="$rose [ M : $normal$mus...$rose ]"
	else
		mus=$(mpc current)
		mcp="$rose [ M : $normal$mus$rose ]"
	fi
fi
}
#
_quod () {
if [ -f ~/.quodlibet/current ]; then
	art=$(cat ~/.quodlibet/current | grep artist | cut -d '=' -f2)
	tit=$(cat ~/.quodlibet/current | grep title | cut -d '=' -f2)
	mus="$art - $tit"
	mus="$rose [ M : $normal$mus$rose ]"
else
	mus="off "
	mus="$rose [ M : $normal$mus$rose ]"
fi
}
#
#
	## IP local ##
_ip () {
if [ -z $(ifconfig wlan0 | grep "inet addr") ]; then
	ip="Non connecté"
	ip="$orange [ I : $normal$ip$orange ]"
else
	ip=$(ifconfig wlan0 | grep "inet addr" | cut -b 21-32)
	ip="$orange [ I : $normal$ip$orange ]"
fi
}
#
#
	## Gmail ##
_mail () {
if [ -z $(ifconfig wlan0 | grep "inet addr") ]; then
	mail="$rouge [ G : $normal ?$rouge ]"
else
	gmailuser="adresse@gmail.com"
	gmailpass="motdepasse"
	mail=$(wget --secure-protocol=TLSv1 -T 3 -t 1 --no-check-certificate --user=$gmailuser --password=$gmailpass http://mail.google.com/mail/feed/atom -q -O - | grep  "<fullcount>" | grep -o "[^/<fullcount>]")
	mail="$rouge [ G : $normal$mail @$rouge ]"
fi
}
#
#
	## Volume ##
_vol () {
status=$(amixer get Master | grep "Mono: P" | awk '{print $6}')
 
if [ "$status" = "[on]" ] ; then
	vol=$(amixer get Master | grep "Mono: P" | awk '{print $4}' | grep -oE "[[:digit:]]{1,}"%)
	vol="$cyan [ V : $normal$vol$cyan ]"
else
	vol="mute"
	vol="$cyan [ V : $normal$vol$cyan ]"
fi
}
#
#
	## Batterie ##    
_bat () {                                                               
path="/proc/acpi/battery/BAT1"
 
if [ $(cat $path/state | grep 'present:' | awk '{print $2}') = "no" ]; then 
	bat="$vert [ B : $normal off$vert ]"
else
	full=`cat $path/info|grep 'last full capacity'|awk -F: '{print $2}'|awk -Fm '{print $1}'`
	current=`cat $path/state|grep 'remaining capacity'|awk -F: '{print $2}'|awk -Fm '{print $1}'` 
	state=$(( $current * 100 / $full))
	if [ $(cat $path/state | grep 'charging' | awk '{print $3}') = "discharging" ]; then
		charge="↓"
		bat="$vert [ B : $normal$state % $charge $vert ]" 
	else
		charge="↑"
		bat="$vert [ B : $normal$state % $charge $vert ]" 
	fi
fi
}
#
#
	## Status ##
status () {
	for arg in $@; do
		_${arg}
		args="${args}  `eval echo '$'$arg`"
	done
	wmfs -s 0 "$args"
	echo "$args"
 
}
#
#
	## Variables ##
	## dat hour uptim ram hdd ram hdd ip mail mcp vol bat quod temp
 
status dat hour uptim ram hdd ip mail mcp vol bat
#
#
