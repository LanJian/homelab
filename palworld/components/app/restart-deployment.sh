#!/bin/bash
set -euxo pipefail

cont=$(kubectl -n palworld get pods -o=jsonpath='{.items[?(@.metadata.labels.app=="app")].metadata.name}')

function exec_rcon_cmd() {
  kubectl exec -n palworld -i pod/$cont -- rcon-cli "$1"
}

exec_rcon_cmd "Broadcast Saving_Server_Data..."
exec_rcon_cmd save
sleep 30
exec_rcon_cmd "Broadcast Backing_up_Server_Data..."
kubectl exec -n palworld -i pod/$cont -- backup
sleep 30

step=5
for i in $(seq 30 -$step 1); do
  exec_rcon_cmd "Broadcast Rebooting_in_${i}_seconds..."
  sleep $step
done

exec_rcon_cmd "Shutdown 1"
sleep 30
kubectl -n palworld rollout restart deployment/palworld-app
