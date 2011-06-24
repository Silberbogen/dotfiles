#!/bin/sh

# Liste d'applications
# Pour l'utiliser, placer la ligne suivante (sans #) parmis les [item] de votre appmenu (ou à la place)
# @include "~/.config/wmfs/wmfsrc-appmenu-items"
# puis executer se script ou faite le executer par votre .xinitrc

# Application list
# Add the following line to your .wmfsrc in the appmenu's [item] list
# @include "~/.config/wmfs/wmfsrc-appmenu-items"
# then launch this script or make the .xinitrc do it

echo "#appmenu-items" > ~/.config/wmfs/wmfsrc-appmenu-items

find /usr/share/applications -name "*.desktop" | while read desktop ; do
	#récupérer le nom et la commande dans $A
	# $nom
	# $comande
	nom=`grep "^Name=" $desktop | sed s/"Name="/""/`
	commande=`grep "^Exec=" $desktop | sed s/"Exec="/""/`
	echo "[item] name = \"$nom\" func = \"spawn\" cmd = \"$commande\" [/item]" >> ~/.config/wmfs/wmfsrc-appmenu-items
done


