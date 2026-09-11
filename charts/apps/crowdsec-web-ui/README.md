# crowdsec-web-ui

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 2026.8.3](https://img.shields.io/badge/AppVersion-2026.8.3-informational?style=flat-square)

crowdsec-web-ui helm package

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/zekker6/helm-charts/issues/new)**

## Source Code

* <https://github.com/TheDuffman85/crowdsec-web-ui>
* <https://github.com/zekker6/helm-charts/tree/main/charts/apps/crowdsec-web-ui>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://zekker6.github.io/helm-charts | common | 0.5.2 |

## TL;DR

```console
helm repo add zekker6 https://zekker6.github.io/helm-charts/
helm repo update
helm install crowdsec-web-ui zekker6/crowdsec-web-ui
```

## Installing the Chart

To install the chart with the release name `crowdsec-web-ui`

```console
helm install crowdsec-web-ui zekker6/crowdsec-web-ui
```

## Uninstalling the Chart

To uninstall the `crowdsec-web-ui` deployment

```console
helm uninstall crowdsec-web-ui
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/zekker6/helm-charts/blob/main/charts/library/common/values.yaml) from the [common library](https://github.com/zekker6/helm-charts/blob/main/charts/library/common).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install crowdsec-web-ui \
  --set env.TZ="America/New York" \
    zekker6/crowdsec-web-ui
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install crowdsec-web-ui zekker6/crowdsec-web-ui -f values.yaml
```

## Migrating from 0.x

Chart 1.0.0 replaces legacy application environment settings with a YAML file rendered from `config`. CrowdSec Web UI ignores deprecated configuration variables when this file exists.

Before upgrading, represent each legacy setting under `config`:

| Legacy environment variable | YAML setting |
|-----------------------------|--------------|
| `DB_DIR` | `config.storage.dataDir` |
| `CROWDSEC_URL` | `config.instances[0].lapi.url` |
| `CROWDSEC_USER` | `config.instances[0].lapi.auth.username` |
| `CROWDSEC_PASSWORD` | `config.instances[0].lapi.auth.password.env` |
| `CROWDSEC_PASSWORD_FILE` | `config.instances[0].lapi.auth.password.file` |
| `CROWDSEC_LOOKBACK_PERIOD` | `config.crowdsec.sync.lookback` |

A Secret-backed password can remain in `envFrom`, but the YAML must reference its environment variable:

```yaml
config:
  instances:
    - id: default
      name: CrowdSec
      lapi:
        url: http://crowdsec:8080
        auth:
          type: password
          username: crowdsec-web-ui
          password:
            env: CROWDSEC_PASSWORD

envFrom:
  - secretRef:
      name: crowdsec-web-ui
```

Supported `CONFIG_*` variables remain available as in-memory overrides. Do not enable `CONFIG_PERSIST_OVERRIDES`, because the chart mounts the generated ConfigMap read-only.

See the upstream [configuration guide](https://github.com/TheDuffman85/crowdsec-web-ui#configuration) and [complete YAML reference](https://github.com/TheDuffman85/crowdsec-web-ui/blob/main/config.example.yaml) for other settings.

## Custom configuration

### Application configuration

The chart renders `config` as `/app/data/config.yaml`. Configure CrowdSec Web UI with the [upstream YAML reference](https://github.com/TheDuffman85/crowdsec-web-ui/blob/main/config.example.yaml).

```yaml
config:
  storage:
    dataDir: /data
  crowdsec:
    sync:
      lookback: 168h
  instances:
    - id: default
      name: CrowdSec
      lapi:
        url: http://crowdsec:8080
        auth:
          type: password
          username: crowdsec-web-ui
          password:
            env: CROWDSEC_PASSWORD

envFrom:
  - secretRef:
      name: crowdsec-web-ui
```

To disable built-in authentication:

```yaml
config:
  # Useful when an external proxy already protects access to the UI.
  auth:
    enabled: false
```

The ConfigMap is read-only. Use `config` as the source of truth instead of `CONFIG_PERSIST_OVERRIDES`.

### How to use with oauth2-proxy

Example values to configure crowdsec-web-ui with oauth2-proxy:
```yaml
service:
  main:
    ports:
      http:
        port: 8081

additionalContainers:
  - name: oauth2-proxy
    image: quay.io/oauth2-proxy/oauth2-proxy:v7.13.0
    imagePullPolicy: IfNotPresent
    envFrom:
      - secretRef:
          name: oauth2-proxy
    args:
      - --http-address=0.0.0.0:8081
      - --upstream=http://localhost:3000
```

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/zekker6/helm-charts/blob/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | See values.yaml | CrowdSec Web UI configuration. See the upstream config.example.yaml file for the complete reference. |
| controller.replicas | int | `1` |  |
| controller.strategy | string | `"Recreate"` |  |
| env | list | `[]` | Environment variables for `CONFIG_*` overrides and secrets referenced by `config`. |
| envFrom | list | `[]` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/theduffman85/crowdsec-web-ui"` | image repository |
| image.tag | string | `"2026.8.3"` | image tag |
| ingress.main.enabled | bool | `false` |  |
| ingress.main.hosts[0].host | string | `"example.local"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.tls | list | `[]` |  |
| persistence.data | object | See values.yaml | Configure persistence for data to use sqlite backend. |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| resources.limits.memory | string | `"256Mi"` |  |
| resources.requests.cpu | string | `"10m"` |  |
| resources.requests.memory | string | `"20Mi"` |  |
| service.main.ports.http.port | int | `3000` |  |

### Older versions

A historical overview of changes can be found on [ArtifactHUB](https://artifacthub.io/packages/helm/zekker6/crowdsec-web-ui?modal=changelog)

## Support

- See the [Docs](http://zekker6.github.io/helm-charts/docs/)
- Open an [issue](https://github.com/zekker6/helm-charts/issues/new)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
