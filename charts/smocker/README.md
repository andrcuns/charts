# smocker

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.17.1](https://img.shields.io/badge/AppVersion-0.17.1-informational?style=flat-square)

[smocker](https://github.com/Thiht/smocker) is a is a simple and efficient HTTP mock server.

## Introduction

This chart deploys [smocker](https://github.com/Thiht/smocker) mock service on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Add Helm repo

```bash
helm repo add andrcuns https://andrcuns.github.io/charts
```

## Installing the Chart

Install this chart using:

```bash
helm install buildkit andrcuns/smocker --values values.yaml
```

The command deploys buildkit-service on the Kubernetes cluster in the default configuration. The [values](#values) section lists the parameters that can be configured during installation.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity |
| image.pullPolicy | string | `"IfNotPresent"` | Pull policy |
| image.repository | string | `"andrcuns/smocker"` | Image name |
| image.tag | string | `""` | Image tag |
| logLevel | string | `"info"` | Smocker log level |
| mocks | list | `[]` | Mocks definitions, see: https://smocker.dev/technical-documentation/mock-definition.html |
| nodeSelector | object | `{}` | Node selector |
| podAnnotations | object | `{}` | Pod annotations |
| resources | object | `{}` | Resource definitions |
| service.adminPort | int | `8081` | Service admin port |
| service.annotations | object | `{}` | Service annotations |
| service.type | string | `"ClusterIP"` | Service type |
| service.webPort | int | `8080` | Service web port |
| tolerations | list | `[]` | Tolerations |
