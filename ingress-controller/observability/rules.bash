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
" | kubectl delete -f -

echo "
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: monitor
  annotations:
    konghq.com/strip-path: 'true'
spec:
  ingressClassName: kong
  rules:
  - http:
      paths:
      - path: /monitor
        pathType: ImplementationSpecific
        backend:
          service:
            name: promstack-grafana
            port:
              number: 80
" | kubectl apply -f -