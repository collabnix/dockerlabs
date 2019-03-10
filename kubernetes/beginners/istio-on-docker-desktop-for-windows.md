# Installing Istio Mesh on Docker for Desktop 2.0.0.3

Download this powershell script to install Istio

```
git clone https://github.com/collabnix/dockerlabs
cd kubernetes/beginners/helm/
```

## Running the below powershell script(You might need to be admin user)

```
.\getLatestIstio.ps1
```

Manual Method:

- Download Istio via https://github.com/istio/istio/releases/tag/1.1.0-rc.3
- Extract the contents.
- Set the environment variable

Copy the absolute path to the bin folder under the downloaded istio-<VERSION_NUMBER> folder e.g.,C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3\bin

- In the Search on the taskbar, look and open "Edit environment variables for my account".
- Under User variables, edit path environment variable and add a new entry pointing to the bin folder as copied above. Save the entries.

## Test Istioctl

Open command prompt and run istioctl.
To Check the version, run istioctl version

```
PS C:\Users\Ajeet_Raina> istioctl version
version.BuildInfo{Version:"1.1.0-rc.3", GitRevision:"653f0050f57c7bfbc238e8a92cce1f0eb6896863", User:"roo
c1a-41c9-11e9-8dad-0a580a2c0205", GolangVersion:"go1.10.4", DockerHub:"docker.io/istio", BuildStatus:"Cle
1.0-rc.2-27-g653f005"}
PS C:\Users\Ajeet_Raina>
```

```
PS C:\Users\Ajeet_Raina> kubectl label namespace default istio-injection=enabled
namespace "default" labeled
PS C:\Users\Ajeet_Raina>
```

```
PS C:\Users\Ajeet_Raina> kubectl get namespace -L istio-injection
NAME          STATUS    AGE       ISTIO-INJECTION
default       Active    23h       enabled
docker        Active    23h
kube-public   Active    23h
kube-system   Active    23h
PS C:\Users\Ajeet_Raina>
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3> kubectl apply -f samples/bookinfo
ookinfo.yaml
service "details" created
deployment.extensions "details-v1" created
service "ratings" created
deployment.extensions "ratings-v1" created
service "reviews" created
deployment.extensions "reviews-v1" created
deployment.extensions "reviews-v2" created
deployment.extensions "reviews-v3" created
service "productpage" created
deployment.extensions "productpage-v1" created
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3>
```

```
PS C:\Users\Ajeet_Raina\Desktop\istio-1.1.0-rc.3-win\istio-1.1.0-rc.3> kubectl apply -f .\samples\bookinfo\networking\booki
nfo-gateway.yaml
unable to recognize ".\\samples\\bookinfo\\networking\\bookinfo-gateway.yaml": no matches for kind "Gateway" in version "ne
tworking.istio.io/v1alpha3"
unable to recognize ".\\samples\\bookinfo\\networking\\bookinfo-gateway.yaml": no matches for kind "VirtualService" in vers
ion "networking.istio.io/v1alpha3"
```

Let us pick up Istio 1.0.5 instead as it matches with our v1beta k8s.



