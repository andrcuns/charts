[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/andrcuns)](https://artifacthub.io/packages/search?repo=andrcuns)

# Helm charts

This repository hosts various helm charts.

## Charts

* [buildkit-service](charts/buildkit-service/README.md)
* [smocker](charts/smocker/README.md)
* **dependabot-gitlab**: migrated to <https://gitlab.com/dependabot-gitlab/chart>

## Development

* Make changes
* Update chart README by running [helm-docs](https://github.com/norwoodj/helm-docs/releases) from repo root

```shell
$ helm-docs
INFO[2021-09-17T21:03:22+03:00] Found Chart directories [charts/buildkit-service, charts/dependabot-gitlab]
INFO[2021-09-17T21:03:22+03:00] Generating README Documentation for chart charts/buildkit-service
INFO[2021-09-17T21:03:22+03:00] Generating README Documentation for chart charts/dependabot-gitlab
```

* Create PR and make sure all jobs pass

## Release

* Trigger `Bump version` workflow with desired chart and semver component parameters
