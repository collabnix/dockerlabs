# Kubernetes Scheduler

-  The task of the Kubernetes Scheduler is to choose a placement.
- While scanning the API server (which it is continuously doing), the Kubernetes Scheduler detects that there is a new Pod without a nodeName parameter. The nodeName is what shows which node should be owning this Pod.
- For every Pod that the scheduler discovers, the scheduler becomes responsible for finding the best Node for that Pod to run on. 
- The Scheduler selects a suitable node for this Pod and updates the Pod definition with the node name (though the nodeName parameter).
- The kubelet on the chosen node is notified that there is a pod that is pending execution.
- The kubelet executes the Pod, and the later starts running on the node.

![](https://raw.githubusercontent.com/collabnix/dockerlabs/master/kubernetes/workshop/img/pod.jpg)

- 
- 
- 