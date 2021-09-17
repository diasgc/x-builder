#! /bin/bash
hh=$1
height=${1:-5}
shift

# Buffer up to the height
do_height()
{
    for ((i = 0; i < height; i++))
    do
        "$@"
    done
}

do_height printf "%-${cols}s\n" ""

# Get dimensions of terminal
cols=$(tput cols)
lines=$(tput lines)

sudo apt-get $@ |&
    while IFS= read -r line
    do 
        sleep 0.01
        if [[ $line =~ ^(Hit|Get|Fetch|Read) ]]
        then
            out=("$line" "${out[@]:0:4}")
        else
            out=("" "${out[@]:0:4}")
            tput cup $((lines - height - 1)) 0
            printf "%-${cols}s\n" "$line"
            do_height printf "%-${cols}s\n" ""
        fi
        tput cup $((lines - height - 1)) 0
        for ((i = height - 1; i >= 0; i--))
        do
            printf "%-${cols}s\n" "${out[i]}"
        done
    done