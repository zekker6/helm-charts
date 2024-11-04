# Sockpuppetbrowser

A Helm chart for sockpuppetbrowser - a headless browser service based on [dgtlmoon/sockpuppetbrowser](https://hub.docker.com/r/dgtlmoon/sockpuppetbrowser).

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `sockpuppetbrowser`:

```console
helm install sockpuppetbrowser .
```

## Configuration

The following table lists the configurable parameters of the sockpuppetbrowser chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Image repository | `dgtlmoon/sockpuppetbrowser` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `env.SCREEN_WIDTH` | Browser screen width | `1920` |
| `env.SCREEN_HEIGHT` | Browser screen height | `1024` |
| `env.SCREEN_DEPTH` | Browser screen depth | `16` |
| `env.MAX_CONCURRENT_CHROME_PROCESSES` | Maximum concurrent Chrome processes | `10` |
| `service.main.ports.http.port` | Service port | `3000` |
| `ingress.main.enabled` | Enable ingress | `false` |

## Security Context

The chart requires SYS_ADMIN capabilities for proper operation of the headless browser. This is configured by default in the values.yaml.
