kubectl logs -f $(kubectl get pods -l name=test-operator -o jsonpath="{.items[0].metadata.name}") ansible
