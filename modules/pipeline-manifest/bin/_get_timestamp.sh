#!/bin/sh

TEMPFILE=$1
TEMPFILE2=$1''2
PIPELINE_MANIFEST_MIRROR_NAMESPACE=$4
timestamp=$(curl --silent --location -H "Authorization: Bearer $REDHAT_REGISTRY_TOKEN" https://registry.redhat.io/v2/$PIPELINE_MANIFEST_MIRROR_NAMESPACE/$2/manifests/$3 | jq '[.history[]]|map(.v1Compatibility|fromjson|.created)|sort|reverse|.[0]')
jq '. + [ {"version": "'$3'", "timestamp": '$timestamp'}]' $TEMPFILE > $TEMPFILE2; mv $TEMPFILE2 $TEMPFILE
