#!/usr/bin/env bash
#
oc create -f 99-metal3-provisioning.yaml >/dev/null 2>&1 || oc patch provisioning provisioning-configuration --type merge -p '{"spec":{"watchAllNamespaces": true}}'

oc wait --for=condition=available multiclusterengine/multiclusterengine --timeout=10m

until oc get crd/agentserviceconfigs.agent-install.openshift.io >/dev/null 2>&1 ; do sleep 1 ; done
until oc get crd/clusterimagesets.hive.openshift.io >/dev/null 2>&1 ; do sleep 1 ; done

if [ "$(which openshift-install)" == "" ] ; then
  VERSION=stable
  TAG=4.12
  kcli download openshift-install -P version=$VERSION -P tag=$TAG
  export PATH=.:$PATH
fi

export RHCOS_ISO=$(openshift-install coreos print-stream-json | jq -r '.["architectures"]["x86_64"]["artifacts"]["metal"]["formats"]["iso"]["disk"]["location"]')
export RHCOS_ROOTFS=$(openshift-install coreos print-stream-json | jq -r '.["architectures"]["x86_64"]["artifacts"]["metal"]["formats"]["pxe"]["rootfs"]["location"]')

export MINOR=$(openshift-install version | head -1 | cut -d' ' -f2 | cut -d. -f1,2)

export PULLSECRET=$(cat ~/openshift_pull.json | tr -d [:space:])
export SSH_PRIV_KEY=$(cat ~/.ssh/id_rsa |sed "s/^/    /")
export VERSION=$(openshift-install coreos print-stream-json | jq -r '.["architectures"]["x86_64"]["artifacts"]["metal"]["release"]')
export RELEASE=$(openshift-install version | grep 'release image' | cut -d' ' -f3)


oc wait -n openshift-machine-api --for=condition=Ready $(oc -n openshift-machine-api  get pod -l baremetal.openshift.io/cluster-baremetal-operator=metal3-state -o name | xargs)

envsubst < assisted-service.sample.yml | oc create -f -
