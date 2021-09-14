```
$ docker build -t aa . && docker run -it --privileged aa
# <...snip...>
(container)# cd shopify
activated shadowenv
35028696c503# ifconfig
veth-shopify: <...snip...>
        inet 192.168.1.11  netmask 255.255.255.0  broadcast 0.0.0.0
        <...snip...>

(container)# cd ../web
activated shadowenv
(container)# ifconfig
veth-web: <...snip...>
        inet 192.168.1.12  netmask 255.255.255.0  broadcast 0.0.0.0
        <...snip...>

(container)#
```
