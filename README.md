# OpenShift ttyd client
Containerized OpenShift CLI tools accessible via ttyd

## What is this?
This provides a web console to a pod with the oc CLI tool available. That's it. 

Need oc but don't have a terminal or the ability to install anything? Just run this as a pod in your project - or run it to share for a whole team.

## How do I use this?

* Create a project in openshift : `oc new-project occli`
* Deploy the OpenShift template : `oc new-app -f https://raw.github.com/roller1187/openshift-ttyd-client/openshift-ttyd-client.json`

## OR Deploy ttyd from the prebuilt image : 
* Deploy app : `oc new-app quay.io/aromerot/openshift-ttyd-client
* Expose route : `oc expose svc/openshift-ttyd-client --port 8080` 

Navigate to the exposed route and login to your OpenShift cluster of choice using the oc command:
>`oc login https://mycluster.awesomeland.com`

and run whatever commands you want:
>`oc get pods --all-namespaces`

