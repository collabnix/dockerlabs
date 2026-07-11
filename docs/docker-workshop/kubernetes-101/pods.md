---
title: "Pods"
---

A **Pod** is the smallest thing Kubernetes can run. It wraps one (or sometimes a few tightly-coupled) containers and gives them a shared network and storage context. When people say "Kubernetes runs my container," what they really mean is "Kubernetes runs my container *inside a Pod*."

Before you can run a Pod, you need an image for it to run - so let's start where you're already comfortable: building a container image with Docker.

## 🛠️ Build the sample app

The project already contains a tiny Node.js web app. Open `server.js` to see it - it does just one thing: respond with its **version** and the **name of the pod** it's running in. That makes it perfect for watching Kubernetes do its job later.

This cluster has its own container registry at `registry.dockerlabs.xyz`. You'll build the image and push it there so the cluster can pull it.

1. Build the image, tagging it for the in-cluster registry:

    ```bash
    docker build -t registry.dockerlabs.xyz/k8s-101/web:1.0 .
    ```

2. Push it so the cluster can pull it:

    ```bash
    docker push registry.dockerlabs.xyz/k8s-101/web:1.0
    ```

:::note
This is the same `docker build` / `docker push` workflow you already use. Kubernetes doesn't build images - it runs images that already exist in a registry.
:::

## 📦 Run your first Pod

The `k8s/pod.yaml` manifest describes a single Pod running the image you just pushed. Take a look - notice it declares *what* you want (a container named `web` using your image), not *how* to start it.

1. Apply the manifest to create the Pod:

    ```bash
    kubectl apply -f k8s/pod.yaml
    ```

2. Watch it come to life. Run this a couple of times until `STATUS` is `Running`:

    ```bash
    kubectl get pods
    ```

3. Get the full story on your Pod - events, image, node, IP, and more:

    ```bash
    kubectl describe pod web
    ```

4. Check the app's logs, just like `docker logs`:

    ```bash
    kubectl logs web
    ```

    You should see a line like `web v1.0 listening on :3000`.

## 🔍 Reach inside the Pod

The Pod has its own internal IP, but let's verify the app responds by running a command *inside* the container - similar to `docker exec`:

```bash
kubectl exec web -- wget -qO- http://localhost:3000/api
```

You'll get back JSON showing the version and the pod name, something like:

```json
{"version":"1.0","pod":"web"}
```

🎉 Your container is running on Kubernetes!

## 💥 Why a bare Pod isn't enough

A lone Pod is fragile. If it dies, nothing brings it back. Let's prove it.

1. Delete the Pod:

    ```bash
    kubectl delete pod web
    ```

2. Check what's running:

    ```bash
    kubectl get pods
    ```

    It's gone - and it's **not coming back**. Nothing is watching over it.

In the real world, containers crash, nodes reboot, and things fail. You don't want your app to simply disappear. In the next section you'll meet the **Deployment** - the object that keeps your app running no matter what. 🚀
