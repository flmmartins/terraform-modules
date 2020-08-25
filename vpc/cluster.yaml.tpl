apiVersion: kops.k8s.io/v1alpha2
kind: Cluster
metadata:
  creationTimestamp: null
  name: dev.k8s.local
spec:
  api:
    loadBalancer:
      type: Public
  authorization:
    rbac: {}
  channel: stable
  cloudProvider: aws
  configBase: s3://${kops_state_name}
  containerRuntime: docker
  etcdClusters:
  - cpuRequest: 200m
    etcdMembers:
    - instanceGroup: master-eu-central-1a
      name: a
    memoryRequest: 100Mi
    name: main
    version: 3.2.24
  - cpuRequest: 100m
    etcdMembers:
    - instanceGroup: master-eu-central-1a
      name: a
    memoryRequest: 100Mi
    name: events
    version: 3.2.24
  iam:
    allowContainerRegistry: true
    legacy: false
  kubelet:
    anonymousAuth: false
  kubernetesApiAccess:
  - 213.127.30.50/32
  kubernetesVersion: 1.18.8
  masterPublicName: api.dev.k8s.local
  networkCIDR: ${vpc_cidr}
  networking:
    calico:
      majorVersion: v3
  nonMasqueradeCIDR: 100.64.0.0/10
  sshAccess:
  - 213.127.30.50/32
  subnets:
  - cidr: 172.20.32.0/19
    name: eu-central-1a
    type: Private
    zone: eu-central-1a
  - cidr: 172.20.0.0/22
    name: utility-eu-central-1a
    type: Utility
    zone: eu-central-1a
  topology:
    dns:
      type: Public
    masters: private
    nodes: private

---

apiVersion: kops.k8s.io/v1alpha2
kind: InstanceGroup
metadata:
  creationTimestamp: null
  labels:
    kops.k8s.io/cluster: dev.k8s.local
  name: master-eu-central-1a
spec:
  associatePublicIp: false
  image: 099720109477/ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20200716
  machineType: t3a.small
  maxSize: 1
  minSize: 1
  nodeLabels:
    kops.k8s.io/instancegroup: master-eu-central-1a
  role: Master
  rootVolumeSize: 10
  subnets:
  - eu-central-1a

---

apiVersion: kops.k8s.io/v1alpha2
kind: InstanceGroup
metadata:
  creationTimestamp: null
  labels:
    kops.k8s.io/cluster: dev.k8s.local
  name: nodes
spec:
  associatePublicIp: false
  image: 099720109477/ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20200716
  machineType: t3a.small
  maxSize: 1
  minSize: 1
  nodeLabels:
    kops.k8s.io/instancegroup: nodes
  role: Node
  rootVolumeSize: 20
  subnets:
  - eu-central-1a
