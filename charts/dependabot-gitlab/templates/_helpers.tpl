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
{{- /* reset checksum since redis and mongodb generates new random password on each deploy if not provided*/ -}}
{{- if and .Values.redis.usePassword (not .Values.redis.existingSecret) }}
checksum/redis-password: {{ default (randAlphaNum 10) .Values.redis.password | sha256sum }}
{{- end }}
{{- if .Values.mongodb.auth.enabled }}
checksum/mongodb-password: {{ default (randAlphaNum 10) .Values.mongodb.auth.password | sha256sum }}
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
Environment config
*/}}
{{- define "dependabot-gitlab.environment" -}}
- name: RAILS_ENV
  value: production
- name: RAILS_SERVE_STATIC_FILES
  value: "true"
- name: SECRET_KEY_BASE
  value: key
- name: SETTINGS__GITLAB_URL
  value: {{ .Values.env.gitlabUrl | quote }}
{{- if .Values.env.sentryDsn }}
- name: SENTRY_DSN
  value: {{ .Values.env.sentryDsn }}
{{- end }}
- name: REDIS_URL
  {{- if .Values.redis.enabled }}
  value: redis://{{ .Values.redis.fullnameOverride }}-master.{{ .Release.Namespace }}.svc.{{ .Values.redis.clusterDomain }}
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
- name: MONGODB_URL
  {{- if .Values.mongodb.enabled }}
  value: {{ .Values.mongodb.fullnameOverride }}.{{ .Release.Namespace }}.svc.{{ .Values.mongodb.clusterDomain }}:{{ .Values.mongodb.service.port }}
  {{- else }}
  value: {{ required "mongodbUrl must be provided" .Values.env.mongodbUrl | quote }}
  {{- end }}
{{- if .Values.mongodb.auth.enabled }}
- name: MONGDODB_DATABASE
  value: {{ .Values.mongodb.auth.database }}
- name: MONGODB_USER
  value: {{ .Values.mongodb.auth.username }}
- name: MONGODB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mongodb.fullnameOverride }}
      key: mongodb-password
{{- end }}
{{- end }}

{{/*
Liveness and startup probes
*/}}
{{- define "dependabot-gitlab.probes" }}
livenessProbe:
  httpGet:
    path: /
    port: http
  periodSeconds: 120
startupProbe:
  httpGet:
    path: /
    port: http
  initialDelaySeconds: 20
  failureThreshold: 20
  periodSeconds: 5
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
