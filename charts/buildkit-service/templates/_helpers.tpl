{{/*
Expand the name of the chart.
*/}}
{{- define "buildkit.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "buildkit.fullname" -}}
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
Image tag
*/}}
{{- define "buildkit.imageTag" -}}
{{- default (.Values.rootless | ternary (printf "%s-rootless" .Chart.AppVersion) .Chart.AppVersion) .Values.image.tag }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "buildkit.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "buildkit.labels" -}}
helm.sh/chart: {{ include "buildkit.chart" . }}
{{ include "buildkit.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "buildkit.selectorLabels" -}}
app.kubernetes.io/name: {{ include "buildkit.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Return the path to the cert file.
*/}}
{{- define "buildkit.tlsCert" -}}
{{- required "Certificate is required when TLS in enabled" .Values.tls.cert -}}
{{- end -}}

{{/*
Return the path to the cert key file.
*/}}
{{- define "buildkit.tlsCertKey" -}}
{{- required "Certificate Key is required when TLS in enabled" .Values.tls.certKey -}}
{{- end -}}

{{/*
Return the path to the CA cert file.
*/}}
{{- define "buildkit.tlsCertCACert" -}}
{{- required "Certificate CA is required when TLS in enabled" .Values.tls.certCA -}}
{{- end -}}
