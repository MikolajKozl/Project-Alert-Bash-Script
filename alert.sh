#!/bin/bash
DOMAIN='https://mikolajkozlowski.pl'
EMAIL='kozmi6@gmail.com'
LOGIN='kozmi6'
APPPASSWORD='****************'

RESULT=$(curl -L -s -o /dev/null -w "%{http_code}" $DOMAIN)
ERROR='Oops! Problem!'
Message_title='ALERT Server down!'
The_body_of_the_message='Oops! Pro8l3m! Status code:'
FILE=/tmp/file1.file

find $FILE &> /dev/null
	
if [ $? = 0 ];
		then
		exit

fi


case $RESULT in
	2*)
		echo "Success! The website is reachable"
		;;
	3*|4*|5*)
		echo "$ERROR"
		echo "Status:$RESULT"
		set -e 
		sendemail -f $EMAIL -t $EMAIL -u "$Message_title" -m "$The_body_of_the_message $RESULT" -s smtp.gmail.com:587 -xu $LOGIN -xp $APPPASSWORD >/dev/null
		set +e
		echo "Message was sent to $EMAIL"
		touch $FILE

esac



