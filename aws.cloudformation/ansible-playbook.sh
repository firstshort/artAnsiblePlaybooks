#!/bin/bash

playbook=$(cygpath $1 -u)
playbook_dir=$(dirname $playbook)
playbook_name=$(basename $playbook)
cd $playbook_dir

log_dir=/var/log/ansible/$playbook_name
mkdir -p $log_dir
log="$log_dir/$playbook_name-$(date +%Y%m%d-%H%M%S).log"

command="ansible-playbook $playbook ${@:2}"
echo "Command: $command" > $log
echo "Command: $command"
echo "Log file: $log"
echo "--------------------------------------------------------------------------------------------------------"
time  $command | tee -a $log
echo "--------------------------------------------------------------------------------------------------------"
