# dependabot-gitlab

![Version: 0.0.8](https://img.shields.io/badge/Version-0.0.8-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.8](https://img.shields.io/badge/AppVersion-0.0.8-informational?style=flat-square)

[dependabot-gitlab](https://gitlab.com/dependabot-gitlab/dependabot) is application providing automated dependency management for gitlab projects

## Introduction

This chart bootstraps dependabot-gitlab deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Configure dependabot-gitlab Helm repo

```bash
helm repo add dependabot https://dependabot-gitlab.gitlab.io/chart
```

## Installing the Chart

Install this chart using:

```bash
helm install dependabot dependabot/dependabot-gitlab --values dependabot-values.yaml
```

The command deploys dependabot-gitlab on the Kubernetes cluster in the default configuration. The [values](#values) section lists the parameters that can be configured during installation.

By default chart installs instance of [redis](https://github.com/bitnami/charts/tree/master/bitnami/redis). To disable this behavior, pass `redis.enabled: false`.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | redis | ~11.2.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity |
| credentials.docker | object | `{}` | Private docker registry credentials |
| credentials.github_access_token | string | `""` | Github access token |
| credentials.gitlab_access_token | string | `""` | Gitlab access token, required |
| credentials.gitlab_auth_token | string | `""` | Gitlab auth token for webhook authentication |
| credentials.maven | object | `{}` | Private maven repository credentials |
| credentials.npm | object | `{}` | Private npm package registry cretentials |
| env.gitlabUrl | string | `"https://gitlab.com"` | Gitlab instance URL |
| env.redisUrl | string | `""` | Redis URL |
| env.sentryDsn | string | `""` | Optional sentry dsn for error reporting |
| fullnameOverride | string | `""` | Override fully qualified app name |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"docker.io/andrcuns/dependabot-gitlab"` | Image to use for deploying |
| image.tag | string | `""` | Image tag |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` | Override chart name |
| nodeSelector | object | `{}` | Node selectors |
| podAnnotations | object | `{}` | Pod annotations |
| redis.cluster.enabled | bool | `false` | Enable redis cluster |
| redis.cluster.slaveCount | int | `2` | Slave count |
| redis.enabled | bool | `true` | Enable redis installation |
| redis.fullnameOverride | string | `"redis"` | Override redis name |
| redis.usePassword | bool | `true` | Use redis password |
| replicaCount | int | `1` |  |
| service.annotations | object | `{}` | Service annotations |
| service.port | int | `3000` | Service pot |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.create | bool | `false` | Create service account |
| serviceAccount.name | string | `""` | Service account name |
| tolerations | list | `[]` | Tolerations |
| web.resources | object | `{}` | Web container resource definitions |
| worker.resources | object | `{}` | Worker container resource definitions |
