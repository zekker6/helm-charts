# karma

![Version: 0.13.0](https://img.shields.io/badge/Version-0.13.0-informational?style=flat-square) ![AppVersion: v0.121](https://img.shields.io/badge/AppVersion-v0.121-informational?style=flat-square)

karma - Alert dashboard for Prometheus Alertmanager

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/zekker6/helm-charts/issues/new)**

## Source Code

* <https://github.com/prymitive/karma>
* <https://github.com/zekker6/helm-charts/tree/main/charts/apps/karma>

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
helm install karma zekker6/karma
```

## Installing the Chart

To install the chart with the release name `karma`

```console
helm install karma zekker6/karma
```

## Uninstalling the Chart

To uninstall the `karma` deployment

```console
helm uninstall karma
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/zekker6/helm-charts/blob/main/charts/library/common/values.yaml) from the [common library](https://github.com/zekker6/helm-charts/blob/main/charts/library/common).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install karma \
  --set env.TZ="America/New York" \
    zekker6/karma
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install karma zekker6/karma -f values.yaml
```

## Custom configuration

N/A

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/zekker6/helm-charts/blob/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | See the following files for additional environment variables: https://github.com/prymitive/karma#docker |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/prymitive/karma"` | image repository |
| image.tag | string | chart.appVersion | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence.data | object | See values.yaml | Configure persistence for data to use sqlite backend. |
| service | object | See values.yaml | Configures service settings for the chart. |

### Older versions

A historical overview of changes can be found on [ArtifactHUB](https://artifacthub.io/packages/helm/zekker6/karma?modal=changelog)

## Support

- See the [Docs](http://zekker6.github.io/helm-charts/docs/)
- Open an [issue](https://github.com/zekker6/helm-charts/issues/new)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
