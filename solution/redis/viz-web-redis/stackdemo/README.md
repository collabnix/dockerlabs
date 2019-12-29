# Building Docker + Redis + Flask 

```
docker-compose build
[manager1] (local) root@192.168.0.16 ~/dockerlabs/solution/redis/viz-web-redis/stackdemo
$ docker-compose build
redis uses an image, skipping
Building web
Step 1/5 : FROM python:3.4-alpine
 ---> c06adcf62f6e
Step 2/5 : ADD . /code
 ---> e215cf042567
Step 3/5 : WORKDIR /code
 ---> Running in 4c8863dbe148
Removing intermediate container 4c8863dbe148
 ---> 13c5e046abfd
Step 4/5 : RUN pip install -r requirements.txt
 ---> Running in 31866b76bdb0
DEPRECATION: Python 3.4 support has been deprecated. pip 19.1 will be the last one supporting it. Please upgrade your Python as Python 3.4 won't be maintained after March 2019 (cf PEP 429).
Collecting flask (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/d8/94/7350820ae209ccdba073f83220cea1c376f2621254d1e0e82609c9a65e58/Flask-1.0.4-py2.py3-none-any.whl (92kB)
Collecting redis (from -r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/32/ae/28613a62eea0d53d3db3147f8715f90da07667e99baeedf1010eb400f8c0/redis-3.3.11-py2.py3-none-any.whl (66kB)
Collecting Jinja2>=2.10 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/65/e0/eb35e762802015cab1ccee04e8a277b03f1d8e53da3ec3106882ec42558b/Jinja2-2.10.3-py2.py3-none-any.whl (125kB)
Collecting Werkzeug>=0.14 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/ce/42/3aeda98f96e85fd26180534d36570e4d18108d62ae36f87694b476b83d6f/Werkzeug-0.16.0-py2.py3-none-any.whl (327kB)
Collecting itsdangerous>=0.24 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/76/ae/44b03b253d6fade317f32c24d100b3b35c2239807046a4c953c7b89fa49e/itsdangerous-1.1.0-py2.py3-none-any.whl
Collecting click>=5.1 (from flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/fa/37/45185cb5abbc30d7257104c434fe0b07e5a195a6847506c074527aa599ec/Click-7.0-py2.py3-none-any.whl (81kB)
Collecting MarkupSafe>=0.23 (from Jinja2>=2.10->flask->-r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz
Building wheels for collected packages: MarkupSafe
  Building wheel for MarkupSafe (setup.py): started
  Building wheel for MarkupSafe (setup.py): finished with status 'done'
  Stored in directory: /root/.cache/pip/wheels/f2/aa/04/0edf07a1b8a5f5f1aed7580fffb69ce8972edc16a505916a77
Successfully built MarkupSafe
Installing collected packages: MarkupSafe, Jinja2, Werkzeug, itsdangerous, click, flask, redis
Successfully installed Jinja2-2.10.3 MarkupSafe-1.1.1 Werkzeug-0.16.0 click-7.0 flask-1.0.4 itsdangerous-1.1.0 redis-3.3.11
You are using pip version 19.0.3, however version 19.1.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
Removing intermediate container 31866b76bdb0
 ---> 93ef846cd134
Step 5/5 : CMD ["python", "app.py"]
 ---> Running in aa95e3bd8e5d
Removing intermediate container aa95e3bd8e5d
 ---> 475549cb6f91
Successfully built 475549cb6f91
Successfully tagged ajeetraina/redis-flask:latest
```

```
docker-compose up -d
```
