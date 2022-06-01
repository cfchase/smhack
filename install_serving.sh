oc new-project opendatahub

oc create -f https://raw.githubusercontent.com/crobby/odh-manifests/smhack/kfdef/kfctl_mesh_serving.yaml
oc create ns istio-system
oc create -f https://gist.githubusercontent.com/VaishnaviHire/2efacf1fb9e702b51b9758d14c7ead22/raw/7fd48dec010d71ca94fe462643012db6b5949bab/sm_resources.yaml

oc create -f gateway.yaml

