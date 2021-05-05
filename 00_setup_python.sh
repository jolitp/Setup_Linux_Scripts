#! /usr/bin/env bash

install_python() {
    sudo apt install python
    sudo apt install python3
}

pyv="$(python -V 2>&1)"
if [[ -z "$pyv" ]]
then
    install_python;
else
    echo "$pyv"
fi
pyv="$(python2 -V 2>&1)"
if [[ -z "$pyv" ]]
then
    install_python;
else
    echo "$pyv"
fi
pyv="$(python3 -V 2>&1)"
if [[ -z "$pyv" ]]
then
    install_python;
else
    echo "$pyv"
fi
