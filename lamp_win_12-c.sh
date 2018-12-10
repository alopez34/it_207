#!/bin/bash
current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
container_directory="/var/www/example.com/public_html"

echo "=========================================================================="
echo "Current Directory:" $current_directory
echo "=========================================================================="
printf -- '\033[32m		CHECKING Creating Database Directory\033[0m\n';
echo "=========================================================================="
mkdir -p databases
echo "=========================================================================="
printf -- '\033[32m		STARTING DOCKER-MACHINE\033[0m\n';
echo "=========================================================================="

docker-machine start
#add mac docker start command

echo "=========================================================================="
printf -- '\033[32m		CLOSING EXISTING LAMP CONTAINERS\033[0m\n';
echo "=========================================================================="

docker stop lamp
docker rm lamp
echo "=========================================================================="
printf -- '\033[32m		GETTING LATEST DOCKER CONTAINER\033[0m\n';
echo "=========================================================================="

docker pull alopez34/it_207:latest
sleep 1s
#MAIN RUN COMMAND HERE
winpty docker container run -d --name lamp  -p 80:80 
--mount type=bind,source="/$current_directory",destination="//var/www/example.com/public_html"
--mount type=bind,source="/$current_directory/databases",destination="//var/lib/mysql/exampleDB"
alopez34/it_207:latest

echo "=========================================================================="
printf -- '\033[32m		RUNNING CONTAINERS \033[0m\n';
echo "=========================================================================="

#OPEN BROWSER START
#Still need to implement
#OPEN BROWSER END
while [ true ]; do
	echo "=========================================================================="
    printf -- '\033[32m		LAMP CONTAINER RUNNING\033[0m\n';
	echo "=========================================================================="
	printf -- '\033[32m		1) Launch Browser to local Website  \033[0m\n';
    printf -- '\033[32m		2) Open Terminal Session to Container  \033[0m\n';
    printf -- '\033[33m		3) Shutdown Container, Keep Docker Running \033[0m\n';
    printf -- '\033[33m		4) Shutdown Container, Shutdown Docker \033[0m\n';
	echo "=========================================================================="
    read -p "Select Option:" input
    if [ "$input" == "1" ]; then
		echo '=========================================================================='
		printf -- '\033[32m Opening Default Browser --> 192.168.99.100 \033[0m\n';
		echo "=========================================================================="
			start http://192.168.99.100	
			open http://192.168.99.100	
			# no need to use /bin/bash instead use /bash
	elif [ "$input" == "2" ]; then
		echo '=========================================================================='
		printf -- '\033[32m OPENING TERMINAL SESSION TO CONTAINER \033[0m\n';
		printf -- '\033[33m	*to exit terminal type "exit" \033[0m\n';
		echo "=========================================================================="		
		winpty docker exec -t -i lamp bash
		# no need to use /bin/bash instead use /bash
    elif [ "$input" == "3" ]; then

		echo "=========================================================================="
        printf -- '\033[33m		LAMP CONTAINER Stopping \033[0m\n';
		printf -- '\033[33m		DOCKER LEFT RUNNING \033[0m\n'; 
		echo "=========================================================================="
		printf -- '\033[33m window closing in 5 seconds \033[0m\n'; 
		docker stop lamp
		sleep 5s
        break
    elif [ "$input" == "4" ]; then
		echo "=========================================================================="
		printf -- '\033[33m		LAMP CONTAINER STOPPING \033[0m\n';
		echo "=========================================================================="		
        docker stop lamp
		docker-machine stop
        break
    else
        printf -- '\033[31m Invalid Input\033[0m\n'
    fi
done

echo "END OF SCRIPT"

