#!/usr/bin/env bash

function progressbar() {
    if [ -z $1 ] || [ -z $2 ] || [ "$1" -gt "$2" ] ; then
        return
    fi
    local performed=$1
    local total=$2
    if [ -z $3 ]; then
        local bar_length=23 # wget size
    else
        local bar_length=$(($3-1)) # considering '>' character
    fi

    local count=`echo $performed $total $bar_length | awk '{ print int(($1*$3)/$2) }'`
    local perc=`echo $performed $total | awk '{ print int($1*100/$2) }'`

    echo -n $perc%\[
    for i in `seq 1 $(($bar_length+1))`; do
    if (("$i" <= "$count")); then
        echo -n =
    else
        if (("$i" == "$(($count+1))")); then
            echo -n '>'
        else
            echo -n ' '
        fi
    fi
    done
    echo \]
}

function percentagebar() {
    progressbar $1 100 $2
}

function testbar() {
    for i in {1..10}; do
        echo -ne "`percentagebar $(($i*10))`\033[0K\r"
    done
    echo
}

