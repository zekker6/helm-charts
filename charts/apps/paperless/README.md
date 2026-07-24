# paperless

![Version: 11.1.0](https://img.shields.io/badge/Version-11.1.0-informational?style=flat-square) ![AppVersion: 3.0.1](https://img.shields.io/badge/AppVersion-3.0.1-informational?style=flat-square)

Paperless - Index and archive all of your scanned paper documents

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/zekker6/helm-charts/issues/new)**

Chart taken from k8s-at-home repo [here](https://github.com/k8s-at-home/charts/tree/master/charts/stable/paperless).

# Breaking changes

## 10.23.0 -> 11.0.0

Upgrades paperless-ngx from 2.20.15 to 3.0.0. Read the [v3 migration guide](https://docs.paperless-ngx.com/migration-v3/) before upgrading.

Upstream only supports upgrading to v3 from appVersion `2.20.15`. If you are on an older
appVersion, upgrade to chart `10.23.0` first.

### `PAPERLESS_SECRET_KEY` is now required

Paperless-ngx v3 refuses to start when `PAPERLESS_SECRET_KEY` is unset. The chart does not
provide a default, so you must set `env.PAPERLESS_SECRET_KEY` yourself:

```yaml
env:
  PAPERLESS_SECRET_KEY: "<your key>"
```

Existing installations were implicitly running with the built-in default of appVersion 2.x.
To keep sessions and signed tokens valid, set it to that value:

```yaml
env:
  PAPERLESS_SECRET_KEY: "e11fl1oa-*ytql8p)(06fbj4ukrlo+n7k&q5+$1md7i+mge=ee"
```

Otherwise generate a new one with `python3 -c "import secrets; print(secrets.token_urlsafe(64))"`
and accept that existing sessions and tokens are invalidated. The literal value `change-me` is
rejected by paperless-ngx.

### `PAPERLESS_DBENGINE` must be explicit

PostgreSQL and MariaDB users must now set the engine instead of relying on it being inferred
from `PAPERLESS_DBHOST`:

```yaml
env:
  PAPERLESS_DBENGINE: postgresql
  PAPERLESS_DBHOST: postgres
```

### Other upstream changes to check before upgrading

- Document and thumbnail encryption is removed. Run `decrypt_documents` **before** upgrading.
- `PAPERLESS_OCR_MODE=skip` / `skip_noarchive` and `PAPERLESS_OCR_SKIP_ARCHIVE_FILE` are removed,
  replaced by `PAPERLESS_OCR_MODE` plus `PAPERLESS_ARCHIVE_FILE_GENERATION`.
- Consumer settings renamed: `PAPERLESS_CONSUMER_POLLING` -> `PAPERLESS_CONSUMER_POLLING_INTERVAL`,
  `PAPERLESS_CONSUMER_INOTIFY_DELAY` -> `PAPERLESS_CONSUMER_STABILITY_DELAY`.
  `PAPERLESS_CONSUMER_IGNORE_PATTERNS` is now regex instead of fnmatch.
- `PAPERLESS_CONSUMER_BARCODE_SCANNER` is removed, zxing-cpp is the only backend.
- Advanced database options (`PAPERLESS_DBSSLMODE`, `PAPERLESS_DB_POOLSIZE`, etc.) are deprecated
  in favour of a single `PAPERLESS_DB_OPTIONS` string.
- Duplicate documents are no longer rejected by default. Set
  `PAPERLESS_CONSUMER_DELETE_DUPLICATES: "true"` to restore the old behaviour.
- Pre/post consume scripts no longer receive positional arguments, only environment variables.
- The search index is rebuilt from scratch on first start (Whoosh replaced by Tantivy) and task
  history is cleared.

## 9.94.0 -> 10.0.0

The chart no longer includes postgresql and redis charts by default.
Previously, it was using a bitnami/postgresql and bitnami/redis which became obsolete after introducing a paid subscription for bitnami docker images.
See these issues for more details:
- https://github.com/bitnami/charts/issues/35164
- https://github.com/zekker6/helm-charts/issues/825

## Source Code

* <https://github.com/paperless-ngx/paperless-ngx>
* <https://github.com/zekker6/helm-charts/tree/main/charts/apps/paperless>

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
helm install paperless zekker6/paperless
```

## Installing the Chart

To install the chart with the release name `paperless`

```console
helm install paperless zekker6/paperless
```

## Uninstalling the Chart

To uninstall the `paperless` deployment

```console
helm uninstall paperless
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/zekker6/helm-charts/blob/main/charts/library/common/values.yaml) from the [common library](https://github.com/zekker6/helm-charts/blob/main/charts/library/common).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install paperless \
  --set env.TZ="America/New York" \
    zekker6/paperless
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install paperless zekker6/paperless -f values.yaml
```

## Custom configuration

N/A

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/zekker6/helm-charts/blob/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | See the following files for additional environment variables: https://github.com/paperless-ngx/paperless-ngx/tree/main/docker/compose/ https://github.com/paperless-ngx/paperless-ngx/blob/main/paperless.conf.example |
| env.COMPOSE_PROJECT_NAME | string | `"paperless"` | Project name |
| env.PAPERLESS_DBENGINE | string | `nil` | Database engine to use: `sqlite`, `postgresql` or `mariadb`. Must be set explicitly when using PostgreSQL or MariaDB since appVersion 3.0.0. |
| env.PAPERLESS_DBHOST | string | `nil` | Database host to use |
| env.PAPERLESS_OCR_LANGUAGE | string | `"eng"` | OCR languages to install |
| env.PAPERLESS_PORT | string | `"8000"` | Port to use |
| env.PAPERLESS_REDIS | string | `nil` | Redis to use |
| env.PAPERLESS_SECRET_KEY | string | `nil` | **Required since appVersion 3.0.0.** Paperless refuses to start when this is unset. Generate one with: `python3 -c "import secrets; print(secrets.token_urlsafe(64))"` Upgrading from a chart version older than 11.0.0? Set this to `e11fl1oa-*ytql8p)(06fbj4ukrlo+n7k&q5+$1md7i+mge=ee` (the built-in default of appVersion 2.x) to keep existing sessions and tokens valid, or pick a new value and accept that they are invalidated. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/paperless-ngx/paperless-ngx"` | image repository |
| image.tag | string | chart.appVersion | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence.consume | object | See values.yaml | Configure volume to monitor for new documents. |
| persistence.data | object | See values.yaml | Configure persistence for data. |
| persistence.export | object | See values.yaml | Configure export volume. |
| persistence.media | object | See values.yaml | Configure persistence for media. |
| service | object | See values.yaml | Configures service settings for the chart. |

### Older versions

A historical overview of changes can be found on [ArtifactHUB](https://artifacthub.io/packages/helm/zekker6/paperless?modal=changelog)

## Support

- See the [Docs](http://zekker6.github.io/helm-charts/docs/)
- Open an [issue](https://github.com/zekker6/helm-charts/issues/new)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
