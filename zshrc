## log out? set timeout in seconds...
## ...and do not log out in some specific terminals:
if [[ "${TERM}" == ([Exa]term*|rxvt|dtterm|screen*) ]] ; then
    unset TMOUT
else
    TMOUT=1800
fi

## ctrl-s will no longer freeze the terminal.
stty erase "^?"

# Immune commands.
setopt nohup

# Append zsh sessions history instead of replacing it.
setopt append_history

# Do not kill jobs if terminal is closed.
setopt auto_continue

autoload -U colors && colors

# Gestion de la couleur pour les TTY
if [ "$TERM" = "linux" ]; then
  echo -en "\e]P01b1b1b" #black
  echo -en "\e]P8555753" #darkgrey
  echo -en "\e]P1ff6b6b" #darkred
  echo -en "\e]P9ff8d8d" #red
  echo -en "\e]P2a3d46e" #darkgreen
  echo -en "\e]PAc8e7a8" #green
  echo -en "\e]P3eaca75" #brown
  echo -en "\e]PBffd155" #yellow
  echo -en "\e]P4435e87" #darkblue
  echo -en "\e]PC587aa4" #blue
  echo -en "\e]P5cf8243" #darkmagenta
  echo -en "\e]PDf6a24f" #magenta
  echo -en "\e]P6789ec6" #darkcyan
  echo -en "\e]PE46a4ff" #cyan
  echo -en "\e]P7ababab" #lightgrey
  echo -en "\e]PFababab" #white
  clear #for background artifacting
fi

export MEMCPU='memcpu'
export PATH="/usr/lib/go:/usr/share/go:~/bin:/bin/:/usr/lib/colorgcc/bin:$PATH"
#export http_proxy="http://127.0.0.1:8123"  # Polipo
export http_proxy="http://127.0.0.1:8118"  # Privoxy
#export http_proxy="http://127.0.0.1:3128"  # Squid (+ Privoxy + TOR)

alias chromium='chromium --proxy-server="http://127.0.0.1:8118" --ignore-gpu-blacklist'
alias ctw='ctw --refresh=10 GMXX0067'
alias gcc='gcc -std=c99'
alias gwibber='torify gwibber'
alias heybuddy='torify heybuddy'
alias identicurse='torify identicurse'
alias irssi='torify irssi'
alias links='torify links'
alias lint='splint'
#alias ls='ls -CF'
alias lynx='torify lynx'
alias mutt='torify mutt'
#alias -g pacman="pacman-color"
alias pino='torify pino'
alias psg='ps -A | grep '
alias qataki='torify qataki'
alias ruby='ruby -KU'
alias tty-clock='tty-clock -sc -C 4'
alias ttyclock='tty-clock -sc -C 4'
#alias ttytter='torify ttytter'
alias vlock='vlock -a'
alias w3m='torify w3m'
alias wetter='ctw --refresh=10 GMXX0067'
alias taschenrechner='speedcrunch'
# gc                                                                                                                                                                     
prefixes=(5 6 8)
for p in $prefixes; do
        compctl -g "*.${p}" ${p}l
        compctl -g "*.go" ${p}g
done
# standard go tools
compctl -g "*.go" gofmt
# gccgo
compctl -g "*.go" gccgo  

PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%# "
RPROMPT="[%{$fg[yellow]%}%?%{$reset_color%}]"

notiz() {
        $EDITOR ~/DropBox_Decoded/notizen/"$*".txt
}

notizsuche() {
        ls -c ~/DropBox_Decoded/notizen/ | grep "$*"
}

#fortune | cowsay
#pal -r 2

9 fortune

