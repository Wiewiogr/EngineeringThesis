#!/bin/bash
lxc exec C$1 -- bash -c "cat ~/.bash_history | tail"
