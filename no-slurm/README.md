# This is the demo of launching a JRM on a EJFAT node, and CP of k8s is set up on the JIRIAF2302 node.

# Run Jobs by Helm Chart
Steps to run tests by Helm chart.
1. Define the ID of the test record. For example, `export $ID=ersap-test`. This ID will be used for Helm chart name.
2. Run [helm install $ID-prom prom/ --set Deployment.name=$ID](demo/no-slurm/prom). This will create prometheus instance in the cluster for the test.
3. Run [helm install $ID-job job/ --set Deployment.name=$ID-job --set Deployment.serviceMonitorLabel=$ID](no-slurm/job). This will create a job in the cluster for the test. ⚠️ Notice that `Deployment.serviceMonitorLabel` can be set to a identical value for multiple deployments if they are supposed to be monitored by the same prometheus instance.

```bash
#!/bin/bash

ID=$1
helm install $ID-prom prom/ --set Deployment.name=$ID
helm install $ID-job job/ --set Deployment.name=$ID-job --set Deployment.serviceMonitorLabel=$ID
```
