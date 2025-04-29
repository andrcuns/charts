# buildkit-service

![Version: 0.10.0](https://img.shields.io/badge/Version-0.10.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.21.0](https://img.shields.io/badge/AppVersion-v0.21.0-informational?style=flat-square)

[buildkit](https://github.com/moby/buildkit) is a toolkit for converting source code to build artifacts in an efficient, expressive and repeatable manner.

buildkit-service wraps [kubernetes](https://github.com/moby/buildkit/tree/master/examples/kubernetes) deployment examples in to helm chart

## Introduction

This chart bootstraps buildkit service deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Add Helm repo

```bash
helm repo add andrcuns https://andrcuns.github.io/charts
```

## Installing the Chart

Install this chart using:

```bash
helm install buildkit andrcuns/buildkit-service --values values.yaml
```

The command deploys buildkit-service on the Kubernetes cluster in the default configuration. The [values](#values) section lists the parameters that can be configured during installation.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity |
| autoscaling.enabled | bool | `false` | Enable horizontal pod auto-scaler |
| autoscaling.maxReplicas | int | `5` | Maximum number of replicas |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` | Target memory utilization percentage |
| buildkitdToml | string | `""` | Custom configuration buildkitd.toml |
| debugLog | bool | `false` | Enable debug logging |
| image.pullPolicy | string | `"IfNotPresent"` | Pull policy |
| image.repository | string | `"moby/buildkit"` | Image name |
| image.tag | string | `""` | Image tag |
| lifecycle | object | `{}` | Lifecycle hooks and termination |
| nodeSelector | object | `{}` | Node selector |
| pdb.minAvailable | int | `1` | Minimum available pods |
| podAnnotations | object | `{}` | Pod annotations |
| preStop | bool | `false` | Enable the preStop script for graceful shutdown, https://github.com/seatgeek/buildkit-prestop-script |
| replicaCount | int | `1` |  |
| resources | object | `{}` | Resource definitions |
| rootless | bool | `false` | Run rootless mode, https://github.com/moby/buildkit/blob/master/docs/rootless.md |
| service.annotations | object | `{}` | Service annotations |
| service.loadbalancerIp | string | `""` | Static ip address for load balancer |
| service.port | int | `1234` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| terminationGracePeriodSeconds | int | `30` |  |
| tls.cert | string | `nil` | Base64 encoded cert.pem |
| tls.certCA | string | `nil` | Base64 encoded ca.pem |
| tls.certKey | string | `nil` | Base64 encoded key.pem |
| tls.enabled | bool | `false` | Enable mTLS, refer to https://github.com/moby/buildkit/tree/master/examples/kubernetes#deployment--service |
| tolerations | list | `[]` | Tolerations |
