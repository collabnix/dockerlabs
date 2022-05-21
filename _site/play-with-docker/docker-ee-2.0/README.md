```
manager1==>sudo add-apt-repository "deb [arch=amd64]
https://storebits.docker.com/ee/ubuntu/<subscription-id>/ubuntu \
$(lsb_release -cs) \
test-2.0"
manager1==>
```

```
curl -fsSL
https://storebits.docker.com/ee/ubuntu/<subscription-id>/ubuntu/gpg |
sudo apt-key add -
```
