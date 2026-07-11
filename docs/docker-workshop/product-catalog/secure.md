---
title: "Secure"
---

## Using Docker Scout

For a Scout demo, the following patch will adjust the Dockerfile to use an older base image and install an older version of Express, allowing you to demo out-of-date base images and vunlerable dependencies.

```
git apply --whitespace=fix demo/scout.patch
```

Let's build the Docker image.


```
docker build -t scout:v1.0 .
```

Search "Express" package and it will instruct that you can fix it by using express 4.17.3+.

Open up `package.json` file and change express version from 4.17.3 to 4.19.2.

Next, run `npm install` before running the following command

```
docker build -t scout:v2.0 .
```

You'll notice that all the H and C vulnerabilities are all gone.
