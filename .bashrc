alias l='ls -la'

##################
# extract/compress

alias tarx="tar -zxvf"
alias tarc="tar -zcvf"
alias jarx="jar -xvf"

###################

# find a file, directory, etc. 

findf () 
{ 
    NAME=$1;
    shift;
    find . -name "*$NAME*" "$@" -print
}

#####################

# cat all files with the corresponding name, living somewhere below `pwd`
# requires findf as defined above

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

####################

# grep through the history

ghist(){
    history | grep -i $1
}

#####################

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

 #####################

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

#######################

# find where some function is defined
whereisfunc() {
    shopt -s extdebug;
    declare -F $1;
    shopt -u extdebug;
}

#######################

#store time and date when command was issued
HISTTIMEFORMAT="%d/%m/%y %T "
# do not put commands in the history if they start with a blank space
HISTCONTROL=ignorespace

