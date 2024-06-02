# Setup Kubernetes Observability

```bash
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install promstack prometheus-community/kube-prometheus-stack --namespace monitoring --version 52.1.0 -f values-monitoring.yaml
```

## Enable Service Monitor

```bash
helm upgrade kong kong/ingress -n kong --set gateway.serviceMonitor.enabled=true --set gateway.serviceMonitor.labels.release=promstack
```

```bash
echo 'apiVersion: configuration.konghq.com/v1
kind: KongClusterPlugin
metadata:
  name: prometheus
  annotations:
    kubernetes.io/ingress.class: kong
  labels:
    global: "true"
plugin: prometheus
config:
  status_code_metrics: true
  bandwidth_metrics: true
  upstream_health_metrics: true
  latency_metrics: true
  per_consumer: false
' | kubectl delete -f -
```

## Access Grafana Dashboard 

```bash
kubectl get secret --namespace monitoring promstack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```