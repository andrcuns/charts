{{/*
Expand the name of the chart.
*/}}
{{- define "dependabot-gitlab.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dependabot-gitlab.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dependabot-gitlab.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dependabot-gitlab.labels" -}}
helm.sh/chart: {{ include "dependabot-gitlab.chart" . }}
{{ include "dependabot-gitlab.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dependabot-gitlab.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dependabot-gitlab.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "dependabot-gitlab.podAnnotations" -}}
checksum/secrets: {{ include (print $.Template.BasePath "/secrets.yaml") . | sha256sum }}
{{- /* reset checksum since redis generates new random password on each deploy */ -}}
{{- if and .Values.redis.usePassword (not .Values.redis.existingSecret) }}
checksum/redis-password: {{ randAlphaNum 10 | sha256sum }}
{{- end }}
{{- with .Values.podAnnotations }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dependabot-gitlab.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dependabot-gitlab.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Redis config
*/}}
{{- define "dependabot-gitlab.redisConfig" -}}
- name: REDIS_URL
{{- if .Values.redis.enabled }}
  value: redis://{{ .Values.redis.fullnameOverride }}-master.{{ .Release.Namespace }}.svc.cluster.local
{{- else }}
  value: {{ required "redisUrl must be provided" .Values.env.redisUrl | quote }}
{{- end }}
{{- if .Values.redis.usePassword }}
- name: REDIS_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.redis.fullnameOverride }}
      key: {{ .Values.redis.fullnameOverride }}-password
{{- end }}
{{- end }}

{{/*
Secrets credentials
*/}}
{{- define "dependabot-gitlab.secrets" -}}
{{- with .Values.credentials -}}
gitlab_access_token: {{ required "Gitlab access token must be provided" .gitlab_access_token }}

{{- if .github_access_token }}
github_access_token: {{ .github_access_token }}
{{- end }}

{{- if .gitlab_auth_token }}
gitlab_auth_token: {{ .gitlab_auth_token }}
{{- end }}

{{- if or (.maven) (.npm) (.docker) }}
credentials:
  {{- if .maven }}
  maven:
    {{- range $registry, $values := .maven }}
    {{ $registry }}:
    {{- range $key, $val := $values }}
      {{ $key }}: {{ $val | quote }}
    {{- end}}
    {{- end }}
  {{- end -}}

  {{- if .npm }}
  npm:
    {{- range $registry, $values := .npm }}
    {{ $registry }}:
    {{- range $key, $val := $values }}
      {{ $key }}: {{ $val | quote }}
    {{- end }}
    {{- end }}
  {{- end -}}

  {{- if .docker }}
  docker:
    {{- range $registry, $values := .docker }}
    {{ $registry }}:
    {{- range $key, $val := $values }}
      {{ $key }}: {{ $val | quote }}
    {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
