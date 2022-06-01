#install odh operator

oc new-project opendatahub

oc create -f https://raw.githubusercontent.com/crobby/odh-manifests/smhack/kfdef/kfctl_mesh_serving.yaml
oc create ns istio-system
oc create -f https://gist.githubusercontent.com/VaishnaviHire/2efacf1fb9e702b51b9758d14c7ead22/raw/7fd48dec010d71ca94fe462643012db6b5949bab/sm_resources.yaml

oc create -f gateway.yaml

#oc label pod etcd maistra.io/expose-route='true' -n opendatahub    #this was updated in the quickstart.yaml manifest on my fork/branch

oc new-project mmtest

oc create -f https://gist.githubusercontent.com/VaishnaviHire/1281ac33f5e8e2d349ad18843a38b386/raw/373dcab8f6515fdae82f9c4b1f25e6a747fd53af/sm_gateway_vs.yaml


oc label namespace mmtest "modelmesh-enabled=true"
oc create -f smm.yaml -n mmtest
oc create -f https://gist.githubusercontent.com/crobby/c823af412263c31481561398ada29764/raw/8f3f11d446d3a35a9def10b033fb94d9266eb5ac/mlserver-0.x.yaml
oc patch deployment modelmesh-serving-mlserver-0.x  -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"sidecar.istio.io/inject\":\"true\"}}}}}"
oc create -f secret.yaml
oc create -f mnist-sklearn.yaml





oc patch deployment modelmesh-serving-mlserver-0.x  -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"sidecar.istio.io/inject\":\"true"}}}}}"


#One per cluster



apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: odh-gateway
  namespace: opendatahub
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"



#One per serving namespace
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: modelmesh
  namespace: <namespace>
spec:
  gateways:
    - opendatahub/odh-gateway
  hosts:
    - '*'
  http:
    - match:
        - uri:
            prefix: /modelmesh/<namespace>
      rewrite:
        uri: /
      route:
        - destination:
            host: modelmesh-serving.<namespace>.svc.cluster.local
            port:
              number: 8008




oc new-project $1
oc create -f https://gist.githubusercontent.com/VaishnaviHire/1281ac33f5e8e2d349ad18843a38b386/raw/373dcab8f6515fdae82f9c4b1f25e6a747fd53af/sm_gateway_vs.yaml


Need to add new namespace to servicemeshmemberroll



