#!/bin/ash

## ENV
${TGT_SSID}=
${TGT_PASSPHRASE}=
${TGT_IP}=
${TGT_MAC}=`arp -a | grep ${TGT_IP} | awk '{print $4}'`

# SETUP
## Init
### login with root nopassword

setup-alpine
#layout               jp
#variant              jp
#hostname             ember
#interface eth0       [enter]
#ip address for eth0  [enter]
#interface wlan0      [enter]
#wireless network     ${SSID}
#Pre-shared key       ${WLANPASS}
#ip address for wlan0 [enter]
#network conf         [enter]
#root password        ${PASS}
#timezone             Japan
#proxy                [enter]
#ntp client           [enter]
#download mirror      [enter]
#ssh server           [none]
#store configs        [enter]
#apk cache            [enter]

sed -i /etc/apk/repositories
    -e '/v3.*\/community/s@^#@@'
apk update
apk upgrade
apk add --no-cache awake openrc util-linux

# Main script
cat > /etc/init.d/ignite <<EOF
#!/sbin/openrc-run

description="when be activated this script, wake-on-lan hardcoding target."

depend() {
    need wpa_supplicant
}

start() {
    ebegin "Starting ignite"
    ping -c 1 ${TGT_IP} > /dev/null
    while [ $? -eq 1 ]
    do
        awake ${TGT_MAC}
        sleep 1m
        ping -c 1 ${TGT_IP} > /dev/null
    done
}

stop() {
    ebegin "Stopping ignite"
    pkill -9 -x ignite
}
EOF
chmod +x /etc/init.d/ignite

# Set auto-start service
rc-update add ignite default
rc-update add wpa_supplicant boot

# Commit changes
lbu include /etc/init.d/ignite
lbu commit -d
reboot
