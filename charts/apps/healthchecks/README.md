# healthchecks

![Version: 1.4.0](https://img.shields.io/badge/Version-1.4.0-informational?style=flat-square) ![AppVersion: 4.2.20260511](https://img.shields.io/badge/AppVersion-4.2.20260511-informational?style=flat-square)

healthchecks helm package

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/zekker6/helm-charts/issues/new)**

# Breaking changes

## 0.3.0 -> 1.0.0

The image tag was bumped from the 2021-era `version-v1.20.0` to `4.1.1`. This crosses the upstream Django 4.0 upgrade, which tightened `CSRF_TRUSTED_ORIGINS` validation (check `4_0.E001`). Entries must now start with a URL scheme (`https://`).

If you had a healthchecks instance running on the old image, its config PVC contains a `local_settings.py` that was auto-generated with a scheme-less value like `CSRF_TRUSTED_ORIGINS = ["hc.example.com"]`. The new image will fail to start with:

```
SystemCheckError: System check identified some issues:
ERRORS:
?: (4_0.E001) As of Django 4.0, the values in the CSRF_TRUSTED_ORIGINS setting must start with a scheme ...
```

Setting the `CSRF_TRUSTED_ORIGINS` env var does **not** fix this — the linuxserver init script only writes it to `local_settings.py` when the key is absent, and the stale line blocks that branch. You must edit the file on the PVC directly, e.g.:

```sh
kubectl -n <ns> exec deploy/healthchecks -- sed -i \
  's|CSRF_TRUSTED_ORIGINS.*|CSRF_TRUSTED_ORIGINS = ["https://hc.example.com"]|' \
  /config/local_settings.py
kubectl -n <ns> rollout restart deploy/healthchecks
```

If the pod is crashlooping and `exec` isn't available, mount the config PVC into a one-shot busybox pod and run the same `sed`.

The `REGENERATE_SETTINGS` env var is no longer honored by the upstream image and should be removed from your values — if you previously set `REGENERATE_SETTINGS: "True"` to force `local_settings.py` regeneration, drop it. The new image manages `local_settings.py` unconditionally on boot (only writing keys that are absent), so the old flag has no effect.

## Source Code

* <https://github.com/linuxserver/docker-healthchecks>
* <https://github.com/healthchecks/healthchecks>

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
helm install healthchecks zekker6/healthchecks
```

## Installing the Chart

To install the chart with the release name `healthchecks`

```console
helm install healthchecks zekker6/healthchecks
```

## Uninstalling the Chart

To uninstall the `healthchecks` deployment

```console
helm uninstall healthchecks
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/zekker6/helm-charts/blob/main/charts/library/common/values.yaml) from the [common library](https://github.com/zekker6/helm-charts/blob/main/charts/library/common).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install healthchecks \
  --set env.TZ="America/New York" \
    zekker6/healthchecks
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install healthchecks zekker6/healthchecks -f values.yaml
```

## Custom configuration

N/A

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/zekker6/helm-charts/blob/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://github.com/linuxserver/docker-healthchecks#parameters) for more details. |
| env.SITE_NAME | string | `"Example Corp HealthChecks"` | The site's name (e.g., "Example Corp HealthChecks") |
| env.SITE_ROOT | string | `"https://healthchecks.domain"` | The site's top-level URL and the port it listens to |
| env.SUPERUSER_EMAIL | string | `"email@healthchecks.io"` | Superuser email |
| env.SUPERUSER_PASSWORD | string | `"myVeryStrongPassword"` | Superuser password |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"linuxserver/healthchecks"` | image repository |
| image.tag | string | `"4.2.20260511"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| persistence.config | object | `{"enabled":false,"mountpath":"/config"}` | Volume used for configuration |
| service | object | See values.yaml | Configures service settings for the chart. |

### Older versions

A historical overview of changes can be found on [ArtifactHUB](https://artifacthub.io/packages/helm/zekker6/healthchecks?modal=changelog)

## Support

- See the [Docs](http://zekker6.github.io/helm-charts/docs/)
- Open an [issue](https://github.com/zekker6/helm-charts/issues/new)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
