oc new-project $1
sed "s/<namespace>/$1/g" vstemplate.yaml > virtualservice.yaml
oc create -f virtualservice.yaml
rm virtualservice.yaml
oc label namespace $1 "modelmesh-enabled=true"
oc create -f smm.yaml -n $1
oc create -f https://gist.githubusercontent.com/crobby/c823af412263c31481561398ada29764/raw/8f3f11d446d3a35a9def10b033fb94d9266eb5ac/mlserver-0.x.yaml -n $1
oc patch deployment modelmesh-serving-mlserver-0.x  -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"sidecar.istio.io/inject\":\"true\"}}}}}" -n $1
oc create -f secret.yaml -n $1
oc create -f mnist-sklearn.yaml -n $1

