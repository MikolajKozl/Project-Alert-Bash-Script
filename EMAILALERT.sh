#!/bin/bash
DOMAIN='https://mikolajkozlowski.pl' # <-- URL link, what website want you monitoring.
EMAIL='kozmi6@gmail.com' # <-- select the email, that collect alert message.
LOGIN='kozmi6' # <-- email login.
APPPASSWORD='****************' # <-- email password in the case gmail, you need to generate API Key, app password is a 16-digit passcode.

RESULT=$(curl -L -s -o /dev/null -w "%{http_code}" $DOMAIN) # <-- command 'curl -L -s -o /dev/null -w "%{http_code}" <URL>' print you http code status of monitored website.
ERROR='Oops! Problem!' # <-- error text.
Message_title='ALERT Server down!' # <-- title alert.
The_body_of_the_message='Oops! Pro8l3m! Status code:' # <-- body of the message.
FILE=/tmp/file1.file # <-- path to directory where script can find file, this file is used to stop SPAM alert's on your mailbox.
# I recommend set schedule and run script every minute. If file exist script stop send mail.
 
find $FILE &> /dev/null # <-- command cheak if file1.file exist
	
if [ $? = 0 ]; # <-- if yes then exit,
		then
		exit

fi


case $RESULT in # <-- in case 200 201 202.. 2* then script output "Success! The website is reachable"
	2*)
		echo "Success! The website is reachable"
		;;
	3*|4*|5*) #<-- in case 3* 4* 5* which means any issue with server and script send you alert
		echo "$ERROR"
		echo "Status:$RESULT"
		set -e 
		sendemail -f $EMAIL -t $EMAIL -u "$Message_title" -m "$The_body_of_the_message $RESULT" -s smtp.gmail.com:587 -xu $LOGIN -xp $APPPASSWORD >/dev/null # <-- I used sednemail tool, with described values.
		set +e
		echo "Message was sent to $EMAIL"
		touch $FILE # <-- at the end script creat a file in /tmp/file1.file

esac



