
## How to stop kubectl proxy and start it again

```
[node1 labs]$ netstat -tulp | grep kubectl
[node1 labs]$ kubectl proxy --address='192.168.0.13' --port=8002 --accept-hosts='.*' &
[1] 5656
[node1 labs]$ Starting to serve on 192.168.0.13:8002

[node1 labs]$ lynx 192.168.0.13:8002


Exiting via interrupt: 2


[node1 labs]$ curl http://192.168.0.13:8002/api/
{
  "kind": "APIVersions",
  "versions": [
    "v1"
  ],
  "serverAddressByClientCIDRs": [
    {
      "clientCIDR": "0.0.0.0/0",
      "serverAddr
  ```
  
  ## How to know Public IP within a Cloud Instance
  
  ```
  
[node1 labs]$ wget http://ipinfo.io/ip -qO -
```
