---
title: "Scaling & Rolling Updates"
---

Two of the most common things you'll ever do in production are **scaling** (running more or fewer copies to match demand) and **upgrading** (shipping a new version without downtime). Kubernetes makes both nearly effortless. Let's do them.

## 📈 Scale up and down

Right now you have 3 replicas. Imagine traffic is spiking and you need more.

1. Scale the Deployment up to 5 replicas:

    ```bash
    kubectl scale deployment web --replicas=5
    ```

2. Watch the two new pods appear - and use `-o wide` to see **which node** each one landed on:

    ```bash
    kubectl get pods -o wide
    ```

    `5` pods now, and notice the `NODE` column: the scheduler spread them across your three nodes. Your Service automatically started load-balancing across all of them - no Service changes needed. This is Kubernetes packing work onto whatever capacity the cluster has.

3. Traffic calmed down? Scale back to 2:

    ```bash
    kubectl scale deployment web --replicas=2
    ```

4. Confirm the Deployment settled at the new count:

    ```bash
    kubectl get deployment web
    ```

:::tip
`kubectl scale` is the quick imperative way. In real life you'd usually edit `replicas` in the YAML and re-apply it, so your Git repo stays the source of truth.
:::

## 🚢 Ship version 2.0

Now the headline feature: updating your running app to a new version with **zero downtime**. Kubernetes does a **rolling update** - it brings up new pods and tears down old ones gradually, so there are always healthy pods serving traffic.

First, build and push a v2 image. The app reads its version from a build argument, so you'll bake in `2.0`:

1. Build the new version:

    ```bash
    docker build --build-arg APP_VERSION=2.0 -t registry.dockerlabs.xyz/k8s-101/web:2.0 .
    ```

2. Push it to the cluster registry:

    ```bash
    docker push registry.dockerlabs.xyz/k8s-101/web:2.0
    ```

3. Tell the Deployment to use the new image. This triggers the rolling update:

    ```bash
    kubectl set image deployment/web web=registry.dockerlabs.xyz/k8s-101/web:2.0
    ```

4. Watch the rollout happen in real time (it shows each step, then exits when done):

    ```bash
    kubectl rollout status deployment/web
    ```

5. Confirm v2 is now serving. Run a few requests through the Service:

    ```bash
    kubectl run client --rm -i --restart=Never --image=busybox -- \
      sh -c 'for i in $(seq 1 4); do wget -qO- http://web/api; done'
    ```

    Every response should now show `"version":"2.0"`. You upgraded a live app without ever taking it offline. 🎉

## ⏪ Roll back in seconds

Shipped a bad version? Kubernetes keeps a history of your rollouts so you can undo instantly.

1. View the rollout history:

    ```bash
    kubectl rollout history deployment/web
    ```

2. Roll back to the previous version:

    ```bash
    kubectl rollout undo deployment/web
    ```

3. Watch it revert, then verify you're back on v1.0:

    ```bash
    kubectl rollout status deployment/web
    kubectl run client --rm -i --restart=Never --image=busybox -- \
      sh -c 'for i in $(seq 1 4); do wget -qO- http://web/api; done'
    ```

    Back to `"version":"1.0"` - a safety net that takes seconds.

:::warning[Important]
Before the final section, roll **forward** to v2.0 again so you finish on the latest version:
```bash
kubectl set image deployment/web web=registry.dockerlabs.xyz/k8s-101/web:2.0
kubectl rollout status deployment/web
```
:::

## 🧠 The big idea

- **Scaling** is one command (or one line of YAML) - the Service adapts automatically.
- **Rolling updates** swap versions gradually so users never see downtime.
- **Rollbacks** undo a release in seconds using built-in revision history.

Your app scales and upgrades cleanly - but it's still only reachable *inside* the cluster. Time to open it up to the outside world. 🌐
