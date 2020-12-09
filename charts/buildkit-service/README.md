# buildkit-service

![Version: 0.0.10](https://img.shields.io/badge/Version-0.0.10-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.8.0](https://img.shields.io/badge/AppVersion-v0.8.0-informational?style=flat-square)

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
| image.pullPolicy | string | `"IfNotPresent"` | Pull policy |
| image.repository | string | `"moby/buildkit"` | Image name |
| image.tag | string | `""` | Image tag |
| nodeSelector | object | `{}` | Node selector |
| podAnnotations | object | `{}` | Pod annotations |
| replicaCount | int | `1` |  |
| resources | object | `{}` | Resource definitions |
| rootless | bool | `false` | Run rootless mode, https://github.com/moby/buildkit/blob/master/docs/rootless.md |
| service.annotations | object | `{}` | Service annotations |
| service.port | int | `1234` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| tls.cert | string | `nil` | Base64 encoded cert.pem |
| tls.certCA | string | `nil` | Base64 encoded ca.pem |
| tls.certKey | string | `nil` | Base64 encoded key.pem |
| tls.enabled | bool | `false` | Enable mTLS, refer to https://github.com/moby/buildkit/tree/master/examples/kubernetes#deployment--service |
| tolerations | list | `[]` | Tolerations |
