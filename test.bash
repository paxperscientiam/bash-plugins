

shopt -s expand_aliases

alias wifi='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'



# # # when the radio is on, the express status is "running"
# # wifi -I |grep Off > /dev/null
# # while [[ $? -eq 0 ]]; do
# #   if [ -z ${ANYBAR_PORT+x} ];then
# #     echo -n "exclamation" | nc -4u -w0 localhost 1738
# #   fi
# #   echo "Network device is off. Trying to connect..."
# #   /usr/sbin/networksetup -setairportpower "${CT_INTERFACE}" on
# #   sleep 5
# #   wifi -I |grep Off > /dev/null
# # done


# IFS=,
# for CNX in ${CT_RELAY_SERVER}
# do
#     if ! /usr/bin/nc -zn4 127.0.0.1 19922 > /dev/null 1>&2
#     then
#         printf '%s: Creating new tunnel connection to relay server.\n' "${tag}" 1>&2
#         createTunnel "${CNX}"
#     fi
# done
# exit


# # # /usr/bin/nc -zn 8.8.8.8 53 > /dev/null
# # # while [[ $? -ne 0 ]]; do
# # # #    wif en1 disassociate
# # #     echo Connecting to Internet.
# # #     /bin/sleep 10
# # # done



# #
# # createTunnel2() {
# #     # -Y for x11 not working
# #     /usr/bin/ssh -vvv -4 -f -N -R 3000:"${CT_RELAY_SERVER}":22 -L3000:"${CT_RELAY_SERVER}":22 aws
# #     if [[ $? -eq 0 ]]; then
# #         printf -v msg '%s: Tunnel to relay server created successfully!\n' "${tag}" ; \
    #     #             log_msg "${msg}"
# #     else
# #         printf -v msg '%s: An error occurred creating a tunnel to relay server. Return code: %s\n' "${tag}" "$?" ; log_err "${msg}"
# #         return 1
# #     fi
# #     return 0[<8;35;13m
# # }

# # if ! /usr/bin/nc -zn4 127.0.0.1 3000 > /dev/null 1>&2
# # then
# #     printf '%s: Creating new tunnel connection to relay server.\n' "${tag}" 1>&2
# #     createTunnel2
# # fi


# # For more info, see Julian Simioni's original post:
# # https://juliansimioni.com/blog/howto-access-a-linux-machine-behind-a-home-router-with-ssh-tunnels/
# # need to test if interface exists don't I?

# #oterh considerations
# #http://blog.fraggod.net/2017/05/14/ssh-reverse-tunnel-ssh-r-caveats-and-tricks.html
# # Problem 3:

# # If these tunnels are not configured on per-system basis, but shipped in some img file to use with multiple devices, they'll all try to bind same listening port for reverse-tunnels, so only one of these will work.

# # Fixes:

# # More complex script to generate listening port for "ssh -R" based on machine id, i.e. serial, MAC, local IP address, etc.

# # Get free port to bind to out-of-band from the server somehow.

# # Can be through same ssh connection, by checking ss/netstat output or /proc/net/tcp there, if commands are allowed there (probably a bad idea for random remote devices).



# # alias wifi='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# # # when the radio is on, the express status is "running"
# # wifi -I |grep Off > /dev/null
# # while [[ $? -eq 0 ]]; do
# #   if [ -z ${ANYBAR_PORT+x} ];then
# #     echo -n "exclamation" | nc -4u -w0 localhost 1738
# #   fi
# #   echo "Network device is off. Trying to connect..."
# #   /usr/sbin/networksetup -setairportpower "${CT_INTERFACE}" on
# #   sleep 5
# #   wifi -I |grep Off > /dev/null
# # done
