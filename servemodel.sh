oc create -f secret.yaml -n $1
oc create -f mnist-sklearn.yaml -n $1

