# Installing Helm on Docker Desktop for Windows 2.0.0.3


```
choco install kubernetes-helm
```

## Installing Tiller

```
PS C:\Users\Ajeet_Raina\Desktop> helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v
.2 --skip-refresh
$HELM_HOME has been configured at C:\Users\Ajeet_Raina\.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installa
Happy Helming!
PS C:\Users\Ajeet_Raina\Desktop>
```

## Update charts repo (Optional)
```
PS C:\Users\Ajeet_Raina\Desktop> helm repo update
Hang tight while we grab the latest from your chart repositories...
...Skip local chart repository
...Successfully got an update from the "incubator" chart repository
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈
PS C:\Users\Ajeet_Raina\Desktop>
```




