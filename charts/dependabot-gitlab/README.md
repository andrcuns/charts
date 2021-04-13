# dependabot-gitlab

![Version: 0.0.38](https://img.shields.io/badge/Version-0.0.38-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.3.7](https://img.shields.io/badge/AppVersion-0.3.7-informational?style=flat-square)

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
| https://charts.bitnami.com/bitnami | mongodb | ~10.12.2 |
| https://charts.bitnami.com/bitnami | redis | ~13.0.1 |

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
| env.appConfigPath | string | `"kube/config"` | Configuration path |
| env.appRootPath | string | `"/home/dependabot/app"` | App root |
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
| projects | list | `[]` | List of projects to create/update on deployment |
| redis.cluster.enabled | bool | `false` | Enable redis cluster |
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
| web.livenessProbe.enabled | bool | `true` | Enable liveness probe |
| web.livenessProbe.failureThreshold | int | `5` | Liveness probe failure thresold |
| web.livenessProbe.periodSeconds | int | `10` | Liveness probe period |
| web.livenessProbe.timeoutSeconds | int | `1` | Liveness probe timeout |
| web.replicaCount | int | `1` | Web container replicas count |
| web.resources | object | `{}` | Web container resource definitions |
| web.startupProbe.enabled | bool | `true` | Enable startup probe |
| web.startupProbe.failureThreshold | int | `12` | Startup probe failure threshold |
| web.startupProbe.initialDelaySeconds | int | `10` | Startup probe initial delay |
| web.startupProbe.periodSeconds | int | `10` | Startup probe period |
| web.startupProbe.timeoutSeconds | int | `3` | Startup probe timeout |
| worker.livenessProbe.enabled | bool | `true` | Enable liveness probe |
| worker.livenessProbe.failureThreshold | int | `2` | Liveness probe failure threshold |
| worker.livenessProbe.periodSeconds | int | `120` | Liveness probe period |
| worker.livenessProbe.timeoutSeconds | int | `3` | Liveness probe timeout |
| worker.replicaCount | int | `1` | Worker container replicas count |
| worker.resources | object | `{}` | Worker container resource definitions |
| worker.startupProbe.enabled | bool | `true` | Enable startup probe |
| worker.startupProbe.failureThreshold | int | `12` | Startup probe failure threshold |
| worker.startupProbe.initialDelaySeconds | int | `10` | Startup probe initial delay |
| worker.startupProbe.periodSeconds | int | `5` | Startup probe period |
| worker.startupProbe.timeoutSeconds | int | `3` | Startup probe timeout |
