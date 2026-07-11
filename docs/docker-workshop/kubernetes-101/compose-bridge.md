---
title: "Bonus: From Compose to Kubernetes with Compose Bridge"
---

You just hand-wrote Pods, Deployments, Services, and Ingresses - and that was the point: you now understand what each one does. But you almost certainly already have `compose.yaml` files for your apps. Wouldn't it be great to turn one into a full set of Kubernetes manifests automatically?

That's **[Docker Compose Bridge](https://docs.docker.com/compose/bridge/)**. It reads a `compose.yaml` and generates Kubernetes manifests (plus Kustomize overlays) - Deployments, Services, NetworkPolicies, and more - following sensible conventions. It's the fastest on-ramp from "I know Compose" to "I'm running on Kubernetes."

## 📄 The starting point: a Compose file

Open `compose-bridge/compose.yaml`. It's a normal Compose file with one modern twist - a top-level `models` element that declares an AI model the app can use (via Docker Model Runner):

```yaml
name: genai-demo

services:
  webchat:
    image: nginx:alpine
    ports:
      - "8080:80"
    models:
      assistant:
        endpoint_var: MODEL_URL
        model_var: MODEL_NAME

models:
  assistant:
    model: ai/smollm2
```

## 🌉 How the manifests were generated

On a machine with Docker Desktop, you'd convert that file with a single command:

```bash
docker compose -f compose-bridge/compose.yaml bridge convert -o compose-bridge/k8s
```

:::note
**Why isn't there a Run button on that command in the Labspace?** `compose bridge convert` runs a helper container that needs to bind-mount a local directory. The hosted Labspace talks to Docker through a hardened, isolated socket that blocks bind mounts - so the conversion is done **ahead of time** and the results are already committed in `compose-bridge/k8s/`. On your own Docker Desktop, that command runs instantly. The *output* is the interesting part, and it runs perfectly on this cluster - as you're about to see.
:::

## 🔎 Tour the generated manifests

Compose Bridge produced a Kustomize layout. Take a look:

- `compose-bridge/k8s/base/webchat-deployment.yaml` - your service became a Deployment (notice `MODEL_URL` and `MODEL_NAME` were injected as env vars so the app can find the model).
- `compose-bridge/k8s/base/webchat-service.yaml` - a Service for it.
- `compose-bridge/k8s/base/default-network-policy.yaml` - a NetworkPolicy locking down traffic (a nice production touch you got for free).
- `compose-bridge/k8s/overlays/model-runner/model-runner-deployment.yaml` - because you declared a model, the `model-runner` overlay adds a Deployment that runs **Docker Model Runner inside the cluster**, with a PersistentVolumeClaim to store the model and a sidecar that pre-pulls it.

Everything you learned in the earlier sections is right there - just generated for you.

## 🚀 Deploy it to k3s

Apply the `model-runner` overlay. The `-k` flag tells `kubectl` to use Kustomize, which combines the `base` with the overlay:

1. Apply everything to the cluster:

    ```bash
    kubectl apply -k compose-bridge/k8s/overlays/model-runner
    ```

    You'll see a namespace, ConfigMap, Services, a PersistentVolumeClaim, two Deployments, and a NetworkPolicy all created at once.

2. Watch the pods come up in the new `genai-demo` namespace. The model-runner pod pulls the `ai/smollm2` model (~270 MB) on startup, so give it a minute. Re-run until **both** pods show `Running`:

    ```bash
    kubectl get pods -n genai-demo
    ```

:::tip
    To watch live instead of re-running, use `kubectl get pods -n genai-demo -w` and press `Ctrl+C` when both are `Running`.
:::

3. Confirm the in-cluster model runner is alive and serving:

    ```bash
    kubectl get pods -n genai-demo -l com.docker.model.runner=true
    ```

    A `2/2` ready pod means the engine **and** the model-pulling sidecar are both up. 🎉

You took a Compose file and, with one `kubectl apply`, deployed a whole app **plus a live AI model runtime** to Kubernetes. In the final section, you'll talk to it. 🤖
