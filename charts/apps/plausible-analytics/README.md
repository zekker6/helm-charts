# plausible-analytics

![Version: 1.3.0](https://img.shields.io/badge/Version-1.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.2.0](https://img.shields.io/badge/AppVersion-v3.2.0-informational?style=flat-square)

A Helm Chart for Plausible Analytics - a simple and privacy-friendly alternative to Google Analytics

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/zekker6/helm-charts/issues/new)**

Chart was originally created and maintained by [Varac](https://varac.net) [here](https://0xacab.org/varac-projects/plausible-helm-chart).

This chart uses v2.1.0 version of Plausible Analytics.
See release notes to learn more about upgrade steps: https://github.com/plausible/analytics/releases/tag/v2.1.0

## 0.13.1 -> 1.0.0

The chart no longer includes postgresql chart by default.
Previously, it was using a bitnami/postgresql which became obsolete after introducing a paid subscription for bitnami docker images.
See these issues for more details:
- https://github.com/bitnami/charts/issues/35164
- https://github.com/zekker6/helm-charts/issues/825

## Source Code

* <https://github.com/zekker6/helm-charts/tree/main/charts/apps/plausible-analytics>
* <https://hub.docker.com/r/plausible/analytics>
* <https://github.com/plausible/analytics>

## Requirements

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://sentry-kubernetes.github.io/charts | clickhouse | 4.1.1 |

## TL;DR

```console
helm repo add zekker6 https://zekker6.github.io/helm-charts/
helm repo update
helm install plausible-analytics zekker6/plausible-analytics
```

## Installing the Chart

To install the chart with the release name `plausible-analytics`

```console
helm install plausible-analytics zekker6/plausible-analytics
```

## Uninstalling the Chart

To uninstall the `plausible-analytics` deployment

```console
helm uninstall plausible-analytics
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/zekker6/helm-charts/blob/main/charts/library/common/values.yaml) from the [common library](https://github.com/zekker6/helm-charts/blob/main/charts/library/common).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install plausible-analytics \
  --set env.TZ="America/New York" \
    zekker6/plausible-analytics
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install plausible-analytics zekker6/plausible-analytics -f values.yaml
```

## Custom configuration

N/A

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/zekker6/helm-charts/blob/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| baseURL | string | `"http://example.com"` | The hosting url of the server, used for URL generation. In production systems, this should be your ingress host. |
| clickhouse | object | `{"clickhouse":{"image":"clickhouse/clickhouse-server","imageVersion":"24.3.3.102-alpine","replicas":1},"enabled":true}` | Clickhouse Database |
| clickhouse.clickhouse | object | `{"image":"clickhouse/clickhouse-server","imageVersion":"24.3.3.102-alpine","replicas":1}` | Sub-chart values, see https://artifacthub.io/packages/helm/sentry/clickhouse |
| clickhouse.clickhouse.image | string | `"clickhouse/clickhouse-server"` | Latest sentry/clickhouse chart ships 19.14, which doesn't work together with latest plausible https://artifacthub.io/packages/helm/sentry/clickhouse https://hub.docker.com/r/clickhouse/clickhouse-server/tags |
| disableAuth | bool | `false` | Disables authentication completely, no registration, login will be shown. |
| disableRegistration | bool | `false` | Disables registration of new users, keep your admin credentials handy ;) |
| externalSecret | object | `{"name":""}` | Configure an external secret to use for plausible |
| externalSecret.name | string | `""` | Name of the external secret to use |
| extraEnv | list | `[]` | Extra Env Variables that are passed down to plausible 1:1 |
| fullnameOverride | string | `""` |  |
| geolocation.account_id | string | `nil` | Account/User ID from maxmind.com |
| geolocation.enabled | bool | `false` | Enable/Disable the automated fetch of |
| geolocation.license_key | string | `nil` | My License Key from maxmind.com |
| google | object | `{"clientID":null,"clientSecret":null}` | Google Search Integration See: https://docs.plausible.io/self-hosting-configuration#google-search-integration |
| google.clientID | string | `nil` | The Client ID from the Google API Console for your Plausible Analytics project |
| google.clientSecret | string | `nil` | The Client Secret from the Google API Console for your Plausible Analytics project |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/plausible/community-edition"` |  |
| image.tag | string | `"v3.2.0"` | Overrides the image tag whose default is the chart appVersion. See https://hub.docker.com/r/plausible/analytics for tags |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| labels | object | `{}` | Extra Labels to apply on your k8s deployment |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| postgresql | object | `{"url":""}` | Postgres Database |
| postgresql.url | string | `""` | URL format example: url: "postgresql://user:password@host:5432/database_name" Use `extraEnv` in order to pass the DATABASE_URL via external secret |
| postmark | object | `{"apiKey":null}` | Alternatively, you can use Postmark to send transactional emails |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| secretKey | string | `""` | Secret key to be used for encryption. IF no value is provided random string will be generated during release. |
| securityContext | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| smtp | object | `{"enabled":false,"host":null,"mailer":{"adapter":null,"emailAddress":null},"password":null,"port":null,"retries":2,"ssl":{"enabled":false},"username":null}` | Plausible uses and SMTP server to send transactional emails e.g. account activation, password reset, weekly reports, etc. |
| smtp.enabled | bool | `false` | Enable/Disable SMTP functionality |
| smtp.host | string | `nil` | The host address of your smtp server. |
| smtp.mailer.emailAddress | string | `nil` | The email address of the email sender |
| smtp.password | string | `nil` | The password in case SMTP auth is enabled. |
| smtp.port | string | `nil` | The port of your smtp server. |
| smtp.ssl.enabled | bool | `false` | If SSL is enabled for SMTP connection |
| smtp.username | string | `nil` | The username/email in case SMTP auth is enabled. |
| tolerations | list | `[]` |  |
| totpVaultKey | string | `""` | Secret TOTP Vault key to be used for encryption. IF no value is provided random string will be generated during release. Generate with: openssl rand -base64 32 |
| twitter | object | `{"access":{"secret":null,"token":null},"consumer":{"key":null,"secret":null}}` | Twitter Integration https://docs.plausible.io/self-hosting-configuration#twitter-integration |
| twitter.access.secret | string | `nil` | The access token secret you generated in the steps above |
| twitter.access.token | string | `nil` | The access token you generated in the steps above |
| twitter.consumer.key | string | `nil` | The API key from the Twitter Developer Portal |
| twitter.consumer.secret | string | `nil` | The API key secret from the Twitter Developer Portal |

### Older versions

A historical overview of changes can be found on [ArtifactHUB](https://artifacthub.io/packages/helm/zekker6/plausible-analytics?modal=changelog)

## Support

- See the [Docs](http://zekker6.github.io/helm-charts/docs/)
- Open an [issue](https://github.com/zekker6/helm-charts/issues/new)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
