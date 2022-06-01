oc label namespace $1 "modelmesh-enabled=true"
oc apply -f mlserver-0.x.yaml -n $1
oc apply -f triton-2.x.yaml -n $1