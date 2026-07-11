#  How to Test Drive ansible-container on PWD Playground

## Open up https://play-with-docker.com

## Open up the Instance

## Update the APK Repository
```
apk update
```

## Clone the Repository

```
git clone https://github.com/ansible/ansible-container.git
```

## Install Python

```
apk add python
```

## Install python-dev package

```
apk add python-dev
```

## Install 

```
$ cd ansible-container
$ pip install -e .[docker,openshift]
```

## 

```
$ ansible-container init
Ansible Container initialized.
```

## Verify the list of files created

```
ansible.cfg
ansible-requirements.txt
container.yml
meta.yml
requirements.yml
```

## 





## Reference

http://docs.ansible.com/ansible-container/getting_started.html
