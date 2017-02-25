#!/usr/bin/env bash

function progressbar() {
    if [ -z $1 ] || [ -z $2 ]; then
        return
    fi
    performed=$1
    total=$2
    if [ -z $3 ]; then
        bar_length=23 # wget size
    else
        bar_length=$(($3-1)) # considering '>' character
    fi

    count=`echo $performed $total $bar_length | awk '{ print int(($1*$3)/$2) }'`
    perc=`echo $performed $total | awk '{ print int($1*100/$2) }'`

    echo -n $perc%\[
    for i in `seq 1 $bar_length`; do
    if (("$i" <= "$count")); then
        echo -n =
    else
        if (("$i" == "$(($count+1))")); then
            echo -n >
        fi
        echo -n ' '
    fi
    done
    echo \]
}

function percentagebar() {
    progressbar $1 100 $2
}

