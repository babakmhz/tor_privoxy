#!/bin/zsh

# echo "$(whoami)"
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"
print "welcome to my shell script!!!\nconfiguring tor with privoxy\nafter configuring please set your proxy system to 127.0.0.1:8118 / socks proxy: 127.0.0.1:9050" 
input=$1    

copy_config(){
    echo 'configuring privoxy config file... '
    sudo cp /etc/privoxy/config /etc/privoxy/config.sample
    echo 'done!'
}
disable(){
    print 'configuring....'
    echo 'after this oprations please set your system wide proxy to NONE'
    sudo cat /etc/privoxy/config.sample > /etc/privoxy/config
    systemctl stop tor.service ; systemctl stop privoxy.service
    echo 'done!'
}
enable(){
    echo 'after this oprations you need to set your system wide proxy to 127.0.0.1:8118 / socks proxy: 127.0.0.1:9050 '
    echo 'forward-socks5 / localhost:9050 .' >>  /etc/privoxy/config 
    echo 'forward-socks4 / localhost:9050 .' >>  /etc/privoxy/config
    echo 'forward-socks4a / localhost:9050 .' >>  /etc/privoxy/config
    systemctl start tor.service ; systemctl start privoxy.service
    echo 'enebled'
}
ls /etc/privoxy/config.sample || copy_config

 
if [ !$ls_result = "/etc/privoxy/config.sample" ]; then
    echo 'not found!!!'
fi

if [ $input = "d" ]
 then
    disable
elif [ $input = "e" ]
then
    enable
fi




