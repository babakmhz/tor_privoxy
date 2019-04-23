#!/bin/bash

[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

input=$1

copy_config(){
    echo 'configuring privoxy config file... /n ========================'
    sudo cp /etc/privoxy/config /etc/privoxy/config.sample
    echo 'done!'
}
disable(){
    print 'configuring....'
    echo 'you can set your system wide proxy to NONE!'
    sudo cat /etc/privoxy/config.sample > /etc/privoxy/config
    systemctl stop tor.service ; systemctl stop privoxy.service
    echo 'done!'
}
enable(){
    echo 'you need to set your system wide proxy to 127.0.0.1:8118 / socks proxy: 127.0.0.1:9050!'
    echo 'forward-socks5 / localhost:9050 .' >>  /etc/privoxy/config
    echo 'forward-socks4 / localhost:9050 .' >>  /etc/privoxy/config
    echo 'forward-socks4a / localhost:9050 .' >>  /etc/privoxy/config
    systemctl start tor.service ; systemctl start privoxy.service
    echo ''
    echo 'enebled'
}

# restart(){
    
# }

help(){
    echo 'INSTALLATION:'
    echo '    tor_privoxy.sh --install'
    echo 'CONFIGURE:'
    echo '    tor_privoxy.sh --configure <distro_name> <bash_name>'
    echo 'Supported Distro Names:['arch','debian']'
    echo 'Supported Bash Names:['bash','zsh']'

}

# install(){
    
# }


# terminal_config(){
    
# }

echo 'tor privoxy runner V1.0'
echo '========================'

if [ !$ls_result = "/etc/privoxy/config.sample" ]; then
    echo 'not found!!!'
fi

if [ -z "$input" ]
then
    help
elif [ $input = "-e" ]
then
    enable
    
elif [ $input = "-d" ]
then
    disable
fi




