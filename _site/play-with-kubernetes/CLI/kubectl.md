```
Ajeets-MacBook-Air:~ ajeetraina$ kubectl get deployment --help
Display one or many resources. 

Valid resource types include: 

  * all  
  * certificatesigningrequests (aka 'csr')  
  * clusterrolebindings  
  * clusterroles  
  * clusters (valid only for federation apiservers)  
  * componentstatuses (aka 'cs')  
  * configmaps (aka 'cm')  
  * controllerrevisions  
  * cronjobs  
  * customresourcedefinition (aka 'crd')  
  * daemonsets (aka 'ds')  
  * deployments (aka 'deploy')  
  * endpoints (aka 'ep')  
  * events (aka 'ev')  
  * horizontalpodautoscalers (aka 'hpa')  
  * ingresses (aka 'ing')  
  * jobs  
  * limitranges (aka 'limits')  
  * namespaces (aka 'ns')  
  * networkpolicies (aka 'netpol')  
  * nodes (aka 'no')  
  * persistentvolumeclaims (aka 'pvc')  
  * persistentvolumes (aka 'pv')  
  * poddisruptionbudgets (aka 'pdb')  
  * podpreset  
  * pods (aka 'po')  
  * podsecuritypolicies (aka 'psp')  
  * podtemplates  
  * replicasets (aka 'rs')  
  * replicationcontrollers (aka 'rc')  
  * resourcequotas (aka 'quota')  
  * rolebindings  
  * roles  
  * secrets  
  * serviceaccounts (aka 'sa')  
  * services (aka 'svc')  
  * statefulsets  
  * storageclasses  

This command will hide resources that have completed, such as pods that are in
the Succeeded or Failed phases. You can see the full results for any resource by
providing the '--show-all' flag, but this flag does not include the
uninitialized objects by default, unless '--include-uninitialized' is explicitly
set. 

By specifying the output as 'template' and providing a Go template as the value
of the --template flag, you can filter the attributes of the fetched resources.

Examples:
  # List all pods in ps output format.
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name).
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output
format.
  kubectl get replicationcontroller web
  
  # List a single pod in JSON output format.
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON
output format.
  kubectl get -f pod.yaml -o json
  
  # Return only the phase value of the specified pod.
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List all replication controllers and services together in ps output format.
  kubectl get rc,services
  
  # List one or more resources by their type and names.
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List all resources with different types.
  kubectl get all

Options:
      --all-namespaces=false: If present, list the requested object(s) across
all namespaces. Namespace in current context is ignored even if specified with
--namespace.
      --allow-missing-template-keys=true: If true, ignore any errors in
templates when a field or map key is missing in the template. Only applies to
golang and jsonpath output formats.
      --experimental-use-openapi-print-columns=false: If true, use
x-kubernetes-print-column metadata (if present) from openapi schema for
displaying a resource.
      --export=false: If true, use 'export' for the resources.  Exported
resources are stripped of cluster-specific information.
  -f, --filename=[]: Filename, directory, or URL to files identifying the
resource to get from a server.
      --ignore-not-found=false: Treat "resource not found" as a successful
retrieval.
      --include-extended-apis=true: If true, include definitions of new APIs via
calls to the API server. [default true]
      --include-uninitialized=false: If true, the kubectl command applies to
uninitialized objects. If explicitly set to false, this flag overrides other
flags that make the kubectl commands apply to uninitialized objects, e.g.,
"--all". Objects with empty metadata.initializers are regarded as initialized.
  -L, --label-columns=[]: Accepts a comma separated list of labels that are
going to be presented as columns. Names are case-sensitive. You can also use
multiple flag options like -L label1 -L label2...
      --no-headers=false: When using the default or custom-column output format,
don't print headers (default print headers).
  -o, --output='': Output format. One of:
json|yaml|wide|name|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...
See custom columns
[http://kubernetes.io/docs/user-guide/kubectl-overview/#custom-columns], golang
template [http://golang.org/pkg/text/template/#pkg-overview] and jsonpath
template [http://kubernetes.io/docs/user-guide/jsonpath].
      --raw='': Raw URI to request from the server.  Uses the transport
specified by the kubeconfig file.
  -R, --recursive=false: Process the directory used in -f, --filename
recursively. Useful when you want to manage related manifests organized within
the same directory.
  -l, --selector='': Selector (label query) to filter on, supports '=', '==',
and '!='.(e.g. -l key1=value1,key2=value2)
  -a, --show-all=false: When printing, show all resources (default hide
terminated pods.)
      --show-kind=false: If present, list the resource type for the requested
object(s).
      --show-labels=false: When printing, show all labels as the last column
(default hide labels column)
      --sort-by='': If non-empty, sort list types using this field
specification.  The field specification is expressed as a JSONPath expression
(e.g. '{.metadata.name}'). The field in the API resource specified by this
JSONPath expression must be an integer or a string.
      --template='': Template string or path to template file to use when
-o=go-template, -o=go-template-file. The template format is golang templates
[http://golang.org/pkg/text/template/#pkg-overview].
  -w, --watch=false: After listing/getting the requested object, watch for
changes. Uninitialized objects are excluded if no object name is provided.
      --watch-only=false: Watch for changes to the requested object(s), without
listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|wide|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...]
(TYPE [NAME | -l label] | TYPE/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all
commands).

```
