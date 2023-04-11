# matrix

![Version: 2.23.0](https://img.shields.io/badge/Version-2.23.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.81.0](https://img.shields.io/badge/AppVersion-v1.81.0-informational?style=flat-square)

A Helm chart to deploy a Matrix homeserver stack into Kubernetes

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/zekker6/helm-charts/issues/new)**

Chart source: https://github.com/typokign/matrix-chart

## Features

- Latest version of Synapse
- (Optional) Latest version of Riot Web
- (Optional) Choice of lightweight Exim relay or external mail server for email notifications
- (Optional) Coturn TURN server for VoIP calls
- (Optional) PostgreSQL cluster via stable/postgresql chart
- (Optional) [matrix-org/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc) IRC bridge
- (Optional) [tulir/mautrix-whatsapp](https://github.com/tulir/mautrix-whatsapp) WhatsApp bridge
- (Optional) [Half-Shot/matrix-appservice-discord](https://github.com/Half-Shot/matrix-appservice-discord) Discord bridge
- Fully configurable via values.yaml
- Ingress definition for federated Synapse and Riot

## Source Code

* <https://github.com/zekker6/helm-charts/tree/main/charts/apps/matrix>

## Requirements

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 12.x |

## TL;DR

```console
helm repo add zekker6 https://zekker6.github.io/helm-charts/
helm repo update
helm install matrix zekker6/matrix
```

## Installing the Chart

To install the chart with the release name `matrix`

```console
helm install matrix zekker6/matrix
```

## Uninstalling the Chart

To uninstall the `matrix` deployment

```console
helm uninstall matrix
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/zekker6/helm-charts/blob/main/charts/library/common/values.yaml) from the [common library](https://github.com/zekker6/helm-charts/blob/main/charts/library/common).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install matrix \
  --set env.TZ="America/New York" \
    zekker6/matrix
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install matrix zekker6/matrix -f values.yaml
```

## Custom configuration

N/A

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/zekker6/helm-charts/blob/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bridges.affinity | bool | `false` |  |
| bridges.discord.auth.botToken | string | `""` |  |
| bridges.discord.auth.clientId | string | `""` |  |
| bridges.discord.channelName | string | `"[Discord] :guild :name"` |  |
| bridges.discord.data.capacity | string | `"512Mi"` |  |
| bridges.discord.data.storageClass | string | `""` |  |
| bridges.discord.defaultVisibility | string | `"public"` |  |
| bridges.discord.enabled | bool | `false` |  |
| bridges.discord.image.pullPolicy | string | `"Always"` |  |
| bridges.discord.image.repository | string | `"halfshot/matrix-appservice-discord"` |  |
| bridges.discord.image.tag | string | `"latest"` |  |
| bridges.discord.joinLeaveEvents | bool | `true` |  |
| bridges.discord.presence | bool | `true` |  |
| bridges.discord.readReceipt | bool | `true` |  |
| bridges.discord.replicaCount | int | `1` |  |
| bridges.discord.resources | object | `{}` |  |
| bridges.discord.selfService | bool | `false` |  |
| bridges.discord.service.port | int | `9005` |  |
| bridges.discord.service.type | string | `"ClusterIP"` |  |
| bridges.discord.typingNotifications | bool | `true` |  |
| bridges.discord.users.nickname | string | `":nick"` |  |
| bridges.discord.users.username | string | `":username#:tag"` |  |
| bridges.irc.data.capacity | string | `"1Mi"` |  |
| bridges.irc.database | string | `"matrix_irc"` |  |
| bridges.irc.databaseSslVerify | bool | `true` |  |
| bridges.irc.enabled | bool | `false` |  |
| bridges.irc.image.pullPolicy | string | `"IfNotPresent"` |  |
| bridges.irc.image.repository | string | `"matrixdotorg/matrix-appservice-irc"` |  |
| bridges.irc.image.tag | string | `"release-0.22.0-rc1"` |  |
| bridges.irc.presence | bool | `false` |  |
| bridges.irc.replicaCount | int | `1` |  |
| bridges.irc.resources | object | `{}` |  |
| bridges.irc.servers."chat.freenode.net".name | string | `"Freenode"` |  |
| bridges.irc.servers."chat.freenode.net".port | int | `6697` |  |
| bridges.irc.servers."chat.freenode.net".ssl | bool | `true` |  |
| bridges.irc.service.port | int | `9006` |  |
| bridges.irc.service.type | string | `"ClusterIP"` |  |
| bridges.volume.accessMode | string | `"ReadWriteMany"` |  |
| bridges.volume.capacity | string | `"1Mi"` |  |
| bridges.volume.storageClass | string | `""` |  |
| bridges.whatsapp.bot.avatar | string | `"mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr"` |  |
| bridges.whatsapp.bot.displayName | string | `"WhatsApp bridge bot"` |  |
| bridges.whatsapp.bot.username | string | `"whatsappbot"` |  |
| bridges.whatsapp.callNotices | bool | `true` |  |
| bridges.whatsapp.communityName | string | `"whatsapp_{{.Localpart}}={{.Server}}"` |  |
| bridges.whatsapp.connection.maxAttempts | int | `3` |  |
| bridges.whatsapp.connection.qrRegenCount | int | `2` |  |
| bridges.whatsapp.connection.reportRetry | bool | `true` |  |
| bridges.whatsapp.connection.retryDelay | int | `-1` |  |
| bridges.whatsapp.connection.timeout | int | `20` |  |
| bridges.whatsapp.data.capacity | string | `"512Mi"` |  |
| bridges.whatsapp.data.storageClass | string | `""` |  |
| bridges.whatsapp.enabled | bool | `false` |  |
| bridges.whatsapp.image.pullPolicy | string | `"Always"` |  |
| bridges.whatsapp.image.repository | string | `"dock.mau.dev/tulir/mautrix-whatsapp"` |  |
| bridges.whatsapp.image.tag | string | `"latest"` |  |
| bridges.whatsapp.permissions.* | string | `"relaybot"` |  |
| bridges.whatsapp.relaybot.enabled | bool | `false` |  |
| bridges.whatsapp.relaybot.invites | list | `[]` |  |
| bridges.whatsapp.relaybot.management | string | `"!foo:example.com"` |  |
| bridges.whatsapp.replicaCount | int | `1` |  |
| bridges.whatsapp.resources | object | `{}` |  |
| bridges.whatsapp.service.port | int | `29318` |  |
| bridges.whatsapp.service.type | string | `"ClusterIP"` |  |
| bridges.whatsapp.users.displayName | string | `"{{if .Notify}}{{.Notify}}{{else}}{{.Jid}}{{end}} (WA)"` |  |
| bridges.whatsapp.users.username | string | `"whatsapp_{{.}}"` |  |
| coturn.allowGuests | bool | `true` |  |
| coturn.enabled | bool | `true` |  |
| coturn.image.pullPolicy | string | `"IfNotPresent"` |  |
| coturn.image.repository | string | `"instrumentisto/coturn"` |  |
| coturn.image.tag | string | `"4.5"` |  |
| coturn.kind | string | `"DaemonSet"` |  |
| coturn.labels.component | string | `"coturn"` |  |
| coturn.ports.from | int | `49152` |  |
| coturn.ports.to | int | `49172` |  |
| coturn.replicaCount | int | `1` |  |
| coturn.resources | object | `{}` |  |
| coturn.service.type | string | `"ClusterIP"` |  |
| coturn.sharedSecret | string | `""` |  |
| coturn.uris | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.federation | bool | `true` |  |
| ingress.hosts.federation | string | `"matrix-fed.chart-example.local"` |  |
| ingress.hosts.riot | string | `"element.chart-example.local"` |  |
| ingress.hosts.synapse | string | `"matrix.chart-example.local"` |  |
| ingress.tls | list | `[]` |  |
| mail.enabled | bool | `true` |  |
| mail.external.host | string | `""` |  |
| mail.external.password | string | `""` |  |
| mail.external.port | int | `25` |  |
| mail.external.requireTransportSecurity | bool | `true` |  |
| mail.external.username | string | `""` |  |
| mail.from | string | `"Matrix <matrix@example.com>"` |  |
| mail.relay.enabled | bool | `true` |  |
| mail.relay.image.pullPolicy | string | `"IfNotPresent"` |  |
| mail.relay.image.repository | string | `"devture/exim-relay"` |  |
| mail.relay.image.tag | string | `"4.95-r0-4"` |  |
| mail.relay.labels.component | string | `"mail"` |  |
| mail.relay.probes.liveness | object | `{}` |  |
| mail.relay.probes.readiness | object | `{}` |  |
| mail.relay.probes.startup | object | `{}` |  |
| mail.relay.replicaCount | int | `1` |  |
| mail.relay.resources | object | `{}` |  |
| mail.relay.service.port | int | `25` |  |
| mail.relay.service.type | string | `"ClusterIP"` |  |
| mail.riotUrl | string | `""` |  |
| matrix.adminEmail | string | `"admin@example.com"` |  |
| matrix.blockNonAdminInvites | bool | `false` |  |
| matrix.disabled | bool | `false` |  |
| matrix.disabledMessage | string | `""` |  |
| matrix.encryptByDefault | string | `"invite"` |  |
| matrix.federation.allowPublicRooms | bool | `true` |  |
| matrix.federation.enabled | bool | `true` |  |
| matrix.ip_blacklist[0] | string | `"127.0.0.0/8"` |  |
| matrix.ip_blacklist[10] | string | `"198.51.100.0/24"` |  |
| matrix.ip_blacklist[11] | string | `"203.0.113.0/24"` |  |
| matrix.ip_blacklist[12] | string | `"224.0.0.0/4"` |  |
| matrix.ip_blacklist[13] | string | `"::1/128"` |  |
| matrix.ip_blacklist[14] | string | `"fe80::/10"` |  |
| matrix.ip_blacklist[15] | string | `"fc00::/7"` |  |
| matrix.ip_blacklist[16] | string | `"2001:db8::/32"` |  |
| matrix.ip_blacklist[17] | string | `"ff00::/8"` |  |
| matrix.ip_blacklist[18] | string | `"fec0::/10"` |  |
| matrix.ip_blacklist[1] | string | `"10.0.0.0/8"` |  |
| matrix.ip_blacklist[2] | string | `"172.16.0.0/12"` |  |
| matrix.ip_blacklist[3] | string | `"192.168.0.0/16"` |  |
| matrix.ip_blacklist[4] | string | `"100.64.0.0/10"` |  |
| matrix.ip_blacklist[5] | string | `"192.0.0.0/24"` |  |
| matrix.ip_blacklist[6] | string | `"169.254.0.0/16"` |  |
| matrix.ip_blacklist[7] | string | `"192.88.99.0/24"` |  |
| matrix.ip_blacklist[8] | string | `"198.18.0.0/15"` |  |
| matrix.ip_blacklist[9] | string | `"192.0.2.0/24"` |  |
| matrix.logging.rootLogLevel | string | `"WARNING"` |  |
| matrix.logging.sqlLogLevel | string | `"WARNING"` |  |
| matrix.logging.synapseLogLevel | string | `"WARNING"` |  |
| matrix.oidc_providers | list | `[]` |  |
| matrix.presence | bool | `true` |  |
| matrix.registration.allowGuests | bool | `false` |  |
| matrix.registration.autoJoinRooms | list | `[]` |  |
| matrix.registration.disable_verification | bool | `false` |  |
| matrix.registration.enable_3pid_lookup | bool | `true` |  |
| matrix.registration.enabled | bool | `false` |  |
| matrix.retentionPeriod | string | `"7d"` |  |
| matrix.search | bool | `true` |  |
| matrix.security.surpressKeyServerWarning | bool | `true` |  |
| matrix.serverName | string | `"example.com"` |  |
| matrix.telemetry | bool | `false` |  |
| matrix.uploads.maxPixels | string | `"32M"` |  |
| matrix.uploads.maxSize | string | `"10M"` |  |
| matrix.urlPreviews.enabled | bool | `false` |  |
| matrix.urlPreviews.rules.ip.blacklist[0] | string | `"127.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[1] | string | `"10.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[2] | string | `"172.16.0.0/12"` |  |
| matrix.urlPreviews.rules.ip.blacklist[3] | string | `"192.168.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[4] | string | `"100.64.0.0/10"` |  |
| matrix.urlPreviews.rules.ip.blacklist[5] | string | `"169.254.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[6] | string | `"::1/128"` |  |
| matrix.urlPreviews.rules.ip.blacklist[7] | string | `"fe80::/64"` |  |
| matrix.urlPreviews.rules.ip.blacklist[8] | string | `"fc00::/7"` |  |
| matrix.urlPreviews.rules.maxSize | string | `"10M"` |  |
| matrix.urlPreviews.rules.url | object | `{}` |  |
| nameOverride | string | `""` |  |
| networkPolicies.enabled | bool | `false` |  |
| postgresql.database | string | `"matrix"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.hostname | string | `""` |  |
| postgresql.password | string | `"matrix"` |  |
| postgresql.persistence.size | string | `"8Gi"` |  |
| postgresql.port | int | `5432` |  |
| postgresql.primary.initdb.scriptsConfigMap | string | `"{{ .Release.Name }}-postgresql-initdb"` |  |
| postgresql.username | string | `"matrix"` |  |
| riot.branding.authFooterLinks | list | `[]` |  |
| riot.branding.authHeaderLogoUrl | string | `""` |  |
| riot.branding.brand | string | `"Element"` |  |
| riot.branding.welcomeBackgroundUrl | string | `""` |  |
| riot.enabled | bool | `true` |  |
| riot.image.pullPolicy | string | `"IfNotPresent"` |  |
| riot.image.repository | string | `"vectorim/riot-web"` |  |
| riot.image.tag | string | `"v1.7.33"` |  |
| riot.integrations.api | string | `"https://scalar.vector.im/api"` |  |
| riot.integrations.enabled | bool | `true` |  |
| riot.integrations.ui | string | `"https://scalar.vector.im/"` |  |
| riot.integrations.widgets[0] | string | `"https://scalar.vector.im/_matrix/integrations/v1"` |  |
| riot.integrations.widgets[1] | string | `"https://scalar.vector.im/api"` |  |
| riot.integrations.widgets[2] | string | `"https://scalar-staging.vector.im/_matrix/integrations/v1"` |  |
| riot.integrations.widgets[3] | string | `"https://scalar-staging.vector.im/api"` |  |
| riot.integrations.widgets[4] | string | `"https://scalar-staging.riot.im/scalar/api"` |  |
| riot.labels.component | string | `"element"` |  |
| riot.labs[0] | string | `"feature_new_spinner"` |  |
| riot.labs[10] | string | `"feature_custom_themes"` |  |
| riot.labs[1] | string | `"feature_pinning"` |  |
| riot.labs[2] | string | `"feature_custom_status"` |  |
| riot.labs[3] | string | `"feature_custom_tags"` |  |
| riot.labs[4] | string | `"feature_state_counters"` |  |
| riot.labs[5] | string | `"feature_many_integration_managers"` |  |
| riot.labs[6] | string | `"feature_mjolnir"` |  |
| riot.labs[7] | string | `"feature_dm_verification"` |  |
| riot.labs[8] | string | `"feature_bridge_state"` |  |
| riot.labs[9] | string | `"feature_presence_in_room_list"` |  |
| riot.permalinkPrefix | string | `"https://matrix.to"` |  |
| riot.probes.liveness | object | `{}` |  |
| riot.probes.readiness | object | `{}` |  |
| riot.probes.startup | object | `{}` |  |
| riot.replicaCount | int | `1` |  |
| riot.resources | object | `{}` |  |
| riot.roomDirectoryServers[0] | string | `"matrix.org"` |  |
| riot.service.port | int | `80` |  |
| riot.service.type | string | `"ClusterIP"` |  |
| riot.welcomeUserId | string | `""` |  |
| synapse.image.pullPolicy | string | `"IfNotPresent"` |  |
| synapse.image.repository | string | `"matrixdotorg/synapse"` |  |
| synapse.image.tag | string | `"v1.81.0"` |  |
| synapse.labels.component | string | `"synapse"` |  |
| synapse.metrics.annotations | bool | `true` |  |
| synapse.metrics.enabled | bool | `true` |  |
| synapse.metrics.port | int | `9092` |  |
| synapse.probes.liveness.periodSeconds | int | `10` |  |
| synapse.probes.liveness.timeoutSeconds | int | `5` |  |
| synapse.probes.readiness.periodSeconds | int | `10` |  |
| synapse.probes.readiness.timeoutSeconds | int | `5` |  |
| synapse.probes.startup.failureThreshold | int | `6` |  |
| synapse.probes.startup.periodSeconds | int | `5` |  |
| synapse.probes.startup.timeoutSeconds | int | `5` |  |
| synapse.replicaCount | int | `1` |  |
| synapse.resources | object | `{}` |  |
| synapse.service.federation.port | int | `80` |  |
| synapse.service.federation.type | string | `"ClusterIP"` |  |
| synapse.service.port | int | `80` |  |
| synapse.service.type | string | `"ClusterIP"` |  |
| volumes.media.capacity | string | `"10Gi"` |  |
| volumes.media.storageClass | string | `""` |  |
| volumes.signingKey.capacity | string | `"1Mi"` |  |
| volumes.signingKey.storageClass | string | `""` |  |

### Older versions

A historical overview of changes can be found on [ArtifactHUB](https://artifacthub.io/packages/helm/zekker6/matrix?modal=changelog)

## Support

- See the [Docs](http://zekker6.github.io/helm-charts/docs/)
- Open an [issue](https://github.com/zekker6/helm-charts/issues/new)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
