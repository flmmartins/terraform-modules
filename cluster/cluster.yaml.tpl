apiVersion: kops.k8s.io/v1alpha2
kind: Cluster
metadata:
  name: ${cluster_name}
spec:
  additionalPolicies:
    node: |
      [
        {
          "Effect": "Allow",
          "Action": [
            "acm:ListCertificates",
            "acm:DescribeCertificate",
            "acm:GetCertificate",
            "autoscaling:DescribeAutoScalingGroups",
            "autoscaling:DescribeLoadBalancerTargetGroups",
            "autoscaling:AttachLoadBalancers",
            "autoscaling:DetachLoadBalancers",
            "autoscaling:DetachLoadBalancerTargetGroups",
            "autoscaling:AttachLoadBalancerTargetGroups",
            "cloudformation:*",
            "elasticloadbalancing:*",
            "elasticloadbalancingv2:*",
            "ec2:DescribeInstances",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeRouteTables",
            "ec2:DescribeVpcs",
            "iam:GetServerCertificate",
            "iam:ListServerCertificates"
          ],
          "Resource": ["*"]
       }
      ]
  api:
    loadBalancer:
      type: Public
  authorization:
    rbac: {}
  channel: stable
  cloudProvider: aws
  cloudLabels:
    kubernetes.io/cluster/${cluster_name}: owned
    infra.environment: ${environment}
    infra.part-of: kops
    terraform.module: cluster
    terraform.module.version: ${module_version}
  configBase: s3://${cluster_state_name}/${cluster_name}
  containerRuntime: docker
  etcdClusters:
  - cpuRequest: 200m
    etcdMembers:
    - instanceGroup: master-${region}a
      name: a
    memoryRequest: 100Mi
    name: main
    version: 3.2.24
  - cpuRequest: 100m
    etcdMembers:
    - instanceGroup: master-${region}a
      name: a
    memoryRequest: 100Mi
    name: events
    version: 3.2.24
  iam:
    allowContainerRegistry: true
    legacy: false
  kubelet:
    anonymousAuth: false
  kubernetesApiAccess: ${cluster_api_allowed_ip}
  kubernetesVersion: ${kubernetes_version}
  masterPublicName: api.${cluster_name}
  networkCIDR: ${vpc_cidr}
  networkID: ${vpc_id}
  networking:
    calico:
      majorVersion: v3
  nonMasqueradeCIDR: ${non_masquerade_cidr}
  sshAccess: ${cluster_ssh_allowed_ip}
  subnets:
  - cidr: ${private_subnet_cidr}
    id: ${private_subnet_id}
    name: ${region}a
    type: Private
    zone: ${region}a
  - cidr: ${public_subnet_cidr}
    id: ${public_subnet_id}
    name: utility-${region}a
    type: Utility
    zone: ${region}a
  topology:
    dns:
      type: ${dns_type}
    masters: private
    nodes: private

---

apiVersion: kops.k8s.io/v1alpha2
kind: InstanceGroup
metadata:
  labels:
    kops.k8s.io/cluster: ${cluster_name}
  name: master-${region}a
spec:
  associatePublicIp: false
  image: ${masters_image}
  machineType: ${masters_type}
  maxSize: ${masters_max_num}
  minSize: ${masters_min_num}
  cloudLabels:
    infra.name: master-${region}a
    infra.component: master
  nodeLabels:
    kops.k8s.io/instancegroup: master-${region}a
    infra.part-of: kops
    infra.environment: ${environment}
    terraform.module: cluster
    terraform.module.version: ${module_version}
  role: Master
  rootVolumeSize: 10
  subnets:
  - ${region}a

---

apiVersion: kops.k8s.io/v1alpha2
kind: InstanceGroup
metadata:
  labels:
    kops.k8s.io/cluster: ${cluster_name}
  name: nodes
spec:
  associatePublicIp: false
  image: ${nodes_image}
  machineType: ${nodes_type}
  maxSize: ${nodes_max_num}
  minSize: ${nodes_min_num}
  cloudLabels:
    infra.name: node
    infra.component: node
  nodeLabels:
    kops.k8s.io/instancegroup: nodes
    infra.part-of: kops
    infra.environment: ${environment}
    terraform.module: cluster
    terraform.module.version: ${module_version}
  role: Node
  rootVolumeSize: 20
  subnets:
  - ${region}a
