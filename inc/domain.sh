    echo "Domain Added (MAIN):$MAINDOMAIN (Domain Directory:/home/www)"

while true; do
    read -p "Do You Want Add More Domains?" yn
    case $yn in
        [Yy]* )  echo "."; 
        
        
echo -n "Enter Your Domain seprate by comma(,) For Enable https(Eg. domain.com,domain.in,three.in) > "
read dstring
echo "Request By You Domains: $dstring (...Wait..)"

IFS=', ' read -r -a array <<< "$dstring"
for element in "${array[@]}"
do
    echo -e '<VirtualHost '$MAINIP':80>\nServerName '$element'\nServerAlias www.'$element'\nDocumentRoot /home/www/domain/'$element'\nServerAdmin webmaster@djamol.com\n</VirtualHost>' >> /usr/local/apache2/conf/httpd.conf
    echo -e '$TTL 14400\n@      86400	IN      SOA     ns1.'$MAINDOMAIN'. djamolpatil.gmail.com. (\n		2016033003	; serial, todays date+todays\n		3600		; refresh, seconds\n		7200		; retry, seconds\n		1209600		; expire, seconds\n		86400 )		; minimum, seconds\n\n'$element'. 86400 IN NS ns1.'$MAINDOMAIN'.\n'$element'. 86400 IN NS ns2.'$MAINDOMAIN'.\n\n\n'$element'. IN A '$MAINIP'\nmail.'$element'. IN A '$MAINIP'\nmail.'$element'. IN MX 5 mail.'$element'.\n\nwww IN CNAME '$element'.\nftp IN CNAME '$element'.\n' >> /var/named/$element.db
    echo -e '\nzone "'$element'" {	type master;	file "/var/named/'$element'.db";};' >> /etc/named.main.zones
    echo "Domain Added :$element (Domain Directory:/home/www/domain/$element)"
done


break;;
        [Nn]* ) echo -e "You Select Cancel For More Domain Option";break;;#exit;;
        * ) echo "Please answer yes or no.";;
    esac
done





while true; do
    read -p "Do You Want Domain SSL https connection?" yn
    case $yn in
        [Yy]* )  echo "."; 
        
        
echo -n "Enter Your Additional Domain seprate by comma(,)(Eg. domain.com,domain.in,three.in) > "
read dstring
echo "Request By You Domains For HTTPS Enable: $dstring (...Wait..)"

IFS=', ' read -r -a array <<< "$dstring"
for element in "${array[@]}"
do
echo -e '<VirtualHost '$MAINIP':443>\nServerName '$element'\nServerAlias www.'$element'\nDocumentRoot /home/www/domain/'$element'\n<IfModule mod_ssl.c>\nSSLEngine on\n        SSLCertificateFile /usr/share/ssl/certs/ssl.crt\n        SSLCertificateKeyFile /usr/share/ssl/certs/ssl.crt\n    </IfModule>\n</VirtualHost>\n' >> /usr/local/apache2/conf/httpd.conf
    echo "Domain HTTPS enable :$element Done"
done


break;;
        [Nn]* ) echo -e "You Select Cancel SSL https";break;;#exit;;
        * ) echo "Please answer yes or no.";;
    esac
done







