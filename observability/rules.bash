echo "
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
 name: grafana
 annotations:
   konghq.com/strip-path: 'true'
spec:
 parentRefs:
 - name: kong
 rules:
 - matches:
   - path:
       type: PathPrefix
       value: /grafana
   backendRefs:
   - name: promstack-grafana
     kind: Service
     port: 80
     namespace: monitoring
" | kubectl apply -f -