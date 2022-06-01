This assumes that you already have the ODH operator installed

1.  Run install_serving.sh   This will install a kfdef that includes modelmesh-serving and service mesh.  It will also setup a namespace called istio-system and add a ServiceMeshMemberRoll for the opendatahub namespace along with a ServiceMeshControlPlane.

2.  Run newserving.sh <new namespace name>  This will create a new project to be used for serving models.  It will add the serving runtimes to that namespace, label the namespace for modelmesh-serving, and create a ServiceMeshMember to add this namespace into the mesh defined.
