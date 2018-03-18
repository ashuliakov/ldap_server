#!/bin/bash

# multi-line source file with users data (login password)
INFILE=/tmp/user_list

# output file 
OUTFILE=/tmp/user_add.sql

#user ID variable start value
id=2

while read LINE 
do 
	user=`echo "$LINE" | cut -f1 -d" "` 
	passw=`echo "$LINE" | cut -f2 -d" "` 

	echo "INSERT INTO \`wordpress\`.\`wp_users\` (\`ID\`, \`user_login\`, \`user_pass\`, \`user_nicename\`, \`user_email\`, \`user_url\`, \`user_registered\`, \`user_activation_key\`, \`user_status\`, \`display_name\`) VALUES ('$id', '$user', MD5('$passw'), '$user', '${user}@test.org', 'https://www.test.org', \"`date +"%Y-%m-%d %T"`\", '', '0', '$user');" >> $OUTFILE
	echo "INSERT INTO \`wordpress\`.\`wp_usermeta\` (\`umeta_id\`, \`user_id\`, \`meta_key\`, \`meta_value\`) VALUES (NULL, '$id', 'wp_capabilities', 'a:1:{s:10:\"subscriber\";b:1;}');" >> $OUTFILE
	echo "INSERT INTO \`wordpress\`.\`wp_usermeta\` (\`umeta_id\`, \`user_id\`, \`meta_key\`, \`meta_value\`) VALUES (NULL, '$id', 'wp_user_level', '0');" >> $OUTFILE

(( id++ ))

done < $INFILE
