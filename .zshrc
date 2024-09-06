#========================== Colors ==================================
export COLOR_NC='\[\e[0m\]' # No Color
export COLOR_WHITE='\[\e[1;37m\]'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\[\e[0;34m\]'
export COLOR_LIGHT_BLUE='\[\e[1;34m\]'
export COLOR_LIGHT_GREEN='\[\e[1;32m\]'
export COLOR_CYAN='\[\e[0;36m\]'
export COLOR_LIGHT_CYAN='\[\e[1;36m\]'
export COLOR_RED='\[\e[0;31m\]'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\[\e[0;35m\]'
export COLOR_LIGHT_PURPLE='\[\e[1;35m\]'
export COLOR_BROWN='\[\e[0;33m\]'
export COLOR_GRAY='\[\e[0;30m\]'
export COLOR_LIGHT_GRAY='\[\e[0;37m\]'
export COLOR_YELLOW='\[\e[1;33m\]'
export COLOR_GREEN='\[\e[0;32m\]'


alias l='ls -l'
alias la='ls -la'

# because I _always_ 'l' after 'cd'...
c(){
	cd $1; l;	
}

# extract/compress
alias tarx='tar -zxvf'
alias tarc='tar -zcvf'
alias jarx='jar -xvf'

# create nasty sound
alias annoy='speaker-test -t sine -f 1000 -l 1'

# github
alias githubConnect='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa'

# requires tree (tree utility)
alias tv='tree -a -p -D -C -f | more'
t(){
	if [ $# -eq 0 ]
		then
			tree -L 10 -C | less 
	else
			tree -L $1 -C | less
	fi

}

# find a file, directory, etc. 
findf () 
{ 
    NAME=$1;
    shift;
    find . -name "*$NAME*" "$@" -print
}

# find and open in vim
vf(){
	if [ $# -eq 0 ]
		then
		echo "argument missing"
	else
		vim `find . -name "$1"`;
	fi
}

# cat all files with the corresponding name, living somewhere below `pwd`
# REQUIRES findf as defined above
fat(){
    local STYLE_BOLD='\e[1m'
    local NO_COLOR='\e[0m'
    if [ $# -eq 0 ]
        then
        echo "argument missing"
    else
        for file in `findf $1`;
            do
                printf "$STYLE_BOLD$file$NO_COLOR\n\n";
                cat $file;
                printf "\n\n\n";
            done
    fi
}

# grep through the history
ghist(){
    history | grep -i $1
}

# print a colorized and scroallable tree
# usage: t
# 	 t 3 # to see 3 levels of depth
# REQUIRES: Tree
t(){
    if [ $# -eq 0 ]
        then
            tree -L 10 -C | less -r
    else
            tree -L $1 -C | less -r
    fi

}

# colorize man pages
tman() {
    env \
        LESS_TERMCAP_md=$'\e[1;36m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[1;40;92m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[1;32m' \
            man "$@"
}

# find where some function is defined
whereisfunc() {
    shopt -s extdebug;
    declare -F $1;
    shopt -u extdebug;
}

#store time and date when command was issued
HISTTIMEFORMAT="%d/%m/%y %T "
# do not put commands in the history if they start with a blank space
HISTCONTROL=ignorespace

# terminal prompt
export PROMPT_COMMAND='PS1="-----------------------------\n$COLOR_LIGHT_CYAN\t $COLOR_CYAN\u@\h: $COLOR_LIGHT_BLUE\w $COLOR_LIGHT_GRAY \$(git branch 2>/dev/null | grep \^* | colrm 1 2) $COLOR_BLUE \n$> $COLOR_NC "'

#export PROMPT_COMMAND='PS1="$COLOR_LIGHT_CYAN\t $COLOR_CYAN\u@\h: $COLOR_BLUE$PWD $COLOR_NC$ "'
#export PROMPT_COMMAND="PS1=\"\[\033]0;\u@\h: \w\007\]\u@\h:\w"$PS2"\""

# d - the date in "Weekday Month Date" format (e.g., "Tue May 26")
# e - an ASCII escape character (033)
# h - the hostname up to the first .
# H - the full hostname
# j - the number of jobs currently run in background
# l - the basename of the shells terminal device name
# n - newline
# r - carriage return
# s - the name of the shell, the basename of $0 (the portion following the final slash)
# t - the current time in 24-hour HH:MM:SS format
# T - the current time in 12-hour HH:MM:SS format
# @ - the current time in 12-hour am/pm format
# A - the current time in 24-hour HH:MM format
# u - the username of the current user
# v - the version of bash (e.g., 4.00)
# V - the release of bash, version + patch level (e.g., 4.00.0)
# w - Complete path of current working directory
# W - the basename of the current working directory
# ! - the history number of this command
# # - the command number of this command
# $ - if the effective UID is 0, a #, otherwise a $
# nnn - the character corresponding to the octal number nnn
# \ - a backslash
# [ - begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
# ] - end a sequence of non-printing characters 


# get git autocompletion 
. /Users/$USER/.git-completion.zsh

# FZF 
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -a --ignore .zip --ignore .jar --nocolor --hidden -g ""'
alias f="fzf --preview 'highlight -O ansi -l {} || head -100 {}'"
alias v='vim `fzf --preview "highlight -O ansi -l {} || head -100 {}"`'
filter(){
	if [ $# -eq 0 ]
		then
		echo "argument missing"
	else
		cat "$1" | fzf
	fi
}
