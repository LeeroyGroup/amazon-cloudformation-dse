#!/bin/bash

# Changable parameters
####################################################
aws_profile="${AWS_PROFILE:-default}"
stack="${STACK:-opscenter-stack}"
keyname="${KEY_NAME:-dse-keypair-us-east-1}"
clustername="${CLUSTER_NAME:-mycluster}"
pw="${PASSWORD:-secretpassword}"
# List params
regions=\"${REGIONS:-us-east-1,us-east-1}\"
dcs=\"${DATACENTERS:-dc0,dc1}\"
dcsizes=\"${DATACENTER_SIZES:-3,3}\"
keys=\"${KEYS:-dse-keypair-us-east-1,dse-keypair-us-east-1}\"
instances=\"${INSTANCES:-m4.large,m4.large}\"
volsizes=\"${VOLUME_SIZES:-128,128}\"
####################################################

template="$PWD/cfn-opscenter.json"
aws --profile "$aws_profile" cloudformation create-stack \
--stack-name $stack \
--template-body file://$template \
--capabilities CAPABILITY_IAM \
--parameters \
ParameterKey=Regions,ParameterValue=$regions \
ParameterKey=DataCenters,ParameterValue=$dcs \
ParameterKey=DCSizes,ParameterValue=$dcsizes \
ParameterKey=Keys,ParameterValue=$keys \
ParameterKey=Instances,ParameterValue=$instances \
ParameterKey=VolumeSizes,ParameterValue=$volsizes \
ParameterKey=KeyName,ParameterValue=$keyname \
ParameterKey=ClusterName,ParameterValue=$clustername \
ParameterKey=DBPassword,ParameterValue=$pw
