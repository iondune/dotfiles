#! /bin/bash

red='\e[1;31m'
green='\e[1;32m'
bold='\e[1;37m'
reset='\e[0m'

function ssh_check
{
	count=$(timeout 10.0s ssh -q $1 'w -h | wc -l')
	if [ $? -eq 0 ] ; then
		printf "${bold}%-10s${reset} ${green}OK, %2d users${reset}\n" "${2}" "${count}"
	else
		printf "${bold}%-10s${reset} ${red}timeout${reset}\n" "${2}"
	fi
}

servers="unix1 unix2 unix3 unix4 unix11 unix12 unix13 unix14 vogon multicore falcon tesla"

for server in $servers
do
	address="idunn01@${server}.csc.calpoly.edu"
	if [ -z "$1" ] ; then
		ssh_check $address $server
	else
		ssh_check $address $server &
	fi
done
wait
