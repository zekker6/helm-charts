{{/*
Expand the name of the chart.
*/}}
{{- define "plausible-analytics.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "plausible-analytics.fullname" -}}
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
{{- define "plausible-analytics.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "plausible-analytics.labels" -}}
helm.sh/chart: {{ include "plausible-analytics.chart" . }}
{{ include "plausible-analytics.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "plausible-analytics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "plausible-analytics.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "plausible-analytics.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "plausible-analytics.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "plausible-analytics.env" -}}
{{- if .Values.externalSecret.name }}
envFrom:
- secretRef:
    name: {{ .Values.externalSecret.name }}
{{- if .Values.extraEnv }}
env:
{{ .Values.extraEnv | toYaml }}
{{- end }}
{{- else }}
env:
{{- if (.Values.postgresql.url) }}
- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      key: DATABASE_URL
      name: {{ include "plausible-analytics.fullname" . }}
{{- else }}
  {{ fail "DATABASE_URL is required. Properly set .Values.postgres.url for the connection configuration." }}
{{- end }}

- name: SECRET_KEY_BASE
  valueFrom:
    secretKeyRef:
      key: SECRET_KEY_BASE
      name: {{ include "plausible-analytics.fullname" . }}
- name: TOTP_VAULT_KEY
  valueFrom:
    secretKeyRef:
      key: TOTP_VAULT_KEY
      name: {{ include "plausible-analytics.fullname" . }}
{{- if (or .Values.clickhouse.enabled .Values.clickhouse.url) }}
- name: CLICKHOUSE_DATABASE_URL
  valueFrom:
    secretKeyRef:
      key: CLICKHOUSE_DATABASE_URL
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.disableAuth }}
- name: DISABLE_AUTH
  value: {{ .Values.disableAuth | toString | quote }}
{{- end }}
{{- if .Values.disableRegistration }}
- name: DISABLE_REGISTRATION
  value: {{ .Values.disableRegistration | toString | quote }}
{{- end }}
{{- if .Values.baseURL }}
- name: BASE_URL
  value: {{ .Values.baseURL | toString | quote }}
{{- end }}
{{- if .Values.smtp.enabled }}
{{- if .Values.smtp.mailer.emailAddress }}
- name: MAILER_EMAIL
  valueFrom:
    secretKeyRef:
      key: MAILER_EMAIL
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.smtp.adapter }}
- name: MAILER_ADAPTER
  valueFrom:
    secretKeyRef:
      key: MAILER_ADAPTER
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.smtp.host }}
- name: SMTP_HOST_ADDR
  valueFrom:
    secretKeyRef:
      key: SMTP_HOST_ADDR
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.smtp.port }}
- name: SMTP_HOST_PORT
  valueFrom:
    secretKeyRef:
      key: SMTP_HOST_PORT
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.smtp.username }}
- name: SMTP_USER_NAME
  valueFrom:
    secretKeyRef:
      key: SMTP_USER_NAME
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.smtp.password }}
- name: SMTP_USER_PWD
  valueFrom:
    secretKeyRef:
      key: SMTP_USER_PWD
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.smtp.ssl.enabled }}
- name: SMTP_HOST_SSL_ENABLED
  valueFrom:
    secretKeyRef:
      key: SMTP_HOST_SSL_ENABLED
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.smtp.retires }}
- name: SMTP_RETRIES
  valueFrom:
    secretKeyRef:
      key: SMTP_RETRIES
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- end }}
{{- if .Values.google.clientID }}
- name: GOOGLE_CLIENT_ID
  valueFrom:
    secretKeyRef:
      key: GOOGLE_CLIENT_ID
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.google.clientSecret }}
- name: GOOGLE_CLIENT_SECRET
  valueFrom:
    secretKeyRef:
      key: GOOGLE_CLIENT_SECRET
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.twitter.consumer.key }}
- name: TWITTER_CONSUMER_KEY
  valueFrom:
    secretKeyRef:
      key: TWITTER_CONSUMER_KEY
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.twitter.consumer.secret }}
- name: TWITTER_CONSUMER_SECRET
  valueFrom:
    secretKeyRef:
      key: TWITTER_CONSUMER_SECRET
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.twitter.access.token }}
- name: TWITTER_ACCESS_TOKEN
  valueFrom:
    secretKeyRef:
      key: TWITTER_ACCESS_TOKEN
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.twitter.access.secret }}
- name: TWITTER_ACCESS_TOKEN_SECRET
  valueFrom:
    secretKeyRef:
      key: TWITTER_ACCESS_TOKEN_SECRET
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.postmark.apiKey }}
- name: POSTMARK_API_KEY
  valueFrom:
    secretKeyRef:
      key: POSTMARK_API_KEY
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.geoliteCountryDB }}
- name: GEOLITE2_COUNTRY_DB
  valueFrom:
    secretKeyRef:
      key: GEOLITE2_COUNTRY_DB
      name: {{ include "plausible-analytics.fullname" . }}
{{- end }}
{{- if .Values.extraEnv }}
{{ .Values.extraEnv | toYaml }}
{{- end }}
{{- end }}
{{- end }}
