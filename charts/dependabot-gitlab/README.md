# dependabot-gitlab

![Version: 0.0.23](https://img.shields.io/badge/Version-0.0.23-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.4](https://img.shields.io/badge/AppVersion-0.2.4-informational?style=flat-square)

[dependabot-gitlab](https://gitlab.com/dependabot-gitlab/dependabot) is application providing automated dependency management for gitlab projects

## Introduction

This chart bootstraps dependabot-gitlab deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Add Helm repo

```bash
helm repo add andrcuns https://andrcuns.github.io/charts
```

## Installing the Chart

Install this chart using:

```bash
helm install dependabot andrcuns/dependabot-gitlab --values values.yaml
```

The command deploys dependabot-gitlab on the Kubernetes cluster in the default configuration. The [values](#values) section lists the parameters that can be configured during installation.

By default chart installs instance of [redis](https://github.com/bitnami/charts/tree/master/bitnami/redis). To disable this behavior, pass `redis.enabled: false`.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | ~9.3.1 |
| https://charts.bitnami.com/bitnami | redis | ~11.2.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity |
| credentials.docker | object | `{}` | Private docker registry credentials, multiple repositories referenced by uniqe name: registryName: {registry: registry, username: username, password: password} |
| credentials.github_access_token | string | `""` | Github access token |
| credentials.gitlab_access_token | string | `""` | Gitlab access token, required |
| credentials.gitlab_auth_token | string | `""` | Gitlab auth token for webhook authentication |
| credentials.maven | object | `{}` | Private maven repository credentials, multiple repositories referenced by uniqe name: repoName: {url: url, username: username, password: password} |
| credentials.npm | object | `{}` | Private npm package registry cretentials, multiple repositories referenced by uniqe name: registryName: {registry: registry, token: token} |
| env.dependabotUrl | string | `""` | Optional app url, used for automated webhook creation |
| env.gitlabUrl | string | `"https://gitlab.com"` | Gitlab instance URL |
| env.mongoDbUrl | string | `""` | MongoDB URL |
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
| mongodb.auth.database | string | `"dependabot_gitab"` | MongoDB custom database |
| mongodb.auth.enabled | bool | `true` | Enable authentication |
| mongodb.auth.password | string | `""` | MongoDB custom user password |
| mongodb.auth.rootPassword | string | `""` | MongoDB root password |
| mongodb.auth.username | string | `""` | MongoDB custom user username |
| mongodb.clusterDomain | string | `"cluster.local"` | Kubernetes Cluster Domain |
| mongodb.enabled | bool | `true` | Enable mongodb installation |
| mongodb.fullnameOverride | string | `"mongodb"` | String to fully override mongodb.fullname template |
| mongodb.service.port | int | `27017` | Mongodb service port |
| nameOverride | string | `""` | Override chart name |
| nodeSelector | object | `{}` | Node selectors |
| podAnnotations | object | `{}` | Pod annotations |
| redis.cluster.enabled | bool | `false` | Enable redis cluster |
| redis.cluster.slaveCount | int | `2` | Slave count |
| redis.clusterDomain | string | `"cluster.local"` | Kubernetes Cluster Domain |
| redis.enabled | bool | `true` | Enable redis installation |
| redis.fullnameOverride | string | `"redis"` | Override redis name |
| redis.usePassword | bool | `true` | Use redis password |
| service.annotations | object | `{}` | Service annotations |
| service.port | int | `3000` | Service pot |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.create | bool | `false` | Create service account |
| serviceAccount.name | string | `""` | Service account name |
| tolerations | list | `[]` | Tolerations |
| web.probes.livenessProbe.failureThreshold | int | `20` | Liveness probe failure thresold |
| web.probes.livenessProbe.initialDelaySeconds | int | `10` | Liveness probe initial delay |
| web.probes.livenessProbe.periodSeconds | int | `30` | Liveness probe period |
| web.probes.readinessProbe.failureThreshold | int | `20` | Readiness probe failure threshold |
| web.probes.readinessProbe.initialDelaySeconds | int | `10` | Readiness probe initial delay |
| web.probes.readinessProbe.periodSeconds | int | `30` | Readiness probe period |
| web.probes.startupProbe.failureThreshold | int | `20` | Start probe failure threshold |
| web.probes.startupProbe.initialDelaySeconds | int | `20` | Start probe initial delay |
| web.probes.startupProbe.periodSeconds | int | `5` | Start probe period |
| web.probes.startupProbe.timeoutSeconds | int | `10` | Start probe timeout |
| web.replicaCount | int | `1` | Web container replicas count |
| web.resources | object | `{}` | Web container resource definitions |
| worker.probes.livenessProbe.failureThreshold | int | `20` | Liveness probe failure threshold |
| worker.probes.livenessProbe.initialDelaySeconds | int | `10` | Liveness probe initial delay |
| worker.probes.livenessProbe.periodSeconds | int | `120` | Liveness probe period |
| worker.probes.startupProbe.failureThreshold | int | `20` | Startup probe failure threshold |
| worker.probes.startupProbe.initialDelaySeconds | int | `20` | Startup probe settings |
| worker.probes.startupProbe.periodSeconds | int | `5` | Startup probe period |
| worker.probes.startupProbe.timeoutSeconds | int | `10` | Startup probe timeout |
| worker.replicaCount | int | `1` | Worker container replicas count |
| worker.resources | object | `{}` | Worker container resource definitions |
