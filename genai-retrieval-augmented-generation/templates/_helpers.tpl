{{/*
Expand the name of the chart.
*/}}
{{- define "genai-retrieval-augmented-generation.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "genai-retrieval-augmented-generation.fullname" -}}
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
{{- define "genai-retrieval-augmented-generation.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "genai-retrieval-augmented-generation.labels" -}}
helm.sh/chart: {{ include "genai-retrieval-augmented-generation.chart" . }}
{{ include "genai-retrieval-augmented-generation.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Back-end labels
*/}}
{{- define "genai-retrieval-augmented-generation-retrieval.labels" -}}
helm.sh/chart: {{ include "genai-retrieval-augmented-generation.chart" . }}
{{ include "genai-retrieval-augmented-generation-retrieval.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{/*
Front-end labels
*/}}
{{- define "genai-retrieval-augmented-generation-frontend.labels" -}}
helm.sh/chart: {{ include "genai-retrieval-augmented-generation.chart" . }}
{{ include "genai-retrieval-augmented-generation-frontend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "genai-retrieval-augmented-generation.selectorLabels" -}}
app.kubernetes.io/name: {{ include "genai-retrieval-augmented-generation.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{/*
Front-end Selector labels
*/}}
{{- define "genai-retrieval-augmented-generation-frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "genai-retrieval-augmented-generation.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{/*
Back-end Selector labels
*/}}
{{- define "genai-retrieval-augmented-generation-retrieval.selectorLabels" -}}
app.kubernetes.io/name: {{ include "genai-retrieval-augmented-generation.name" . }}-retrieval
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{/*
Create the name of the service account to use
*/}}
{{- define "genai-retrieval-augmented-generation.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "genai-retrieval-augmented-generation.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
