#!/usr/bin/env bash

status=$(docker service ps $SERVICE_NAME \
    --format "{{ .ID }} {{ .Error }}" \
    --no-trunc \
    | head -n 2 \
    | tail -n 1)

if [[ $status =~ 'non-zero exit' ]]; then
    task_id=$(echo $status | awk '{ print $1 }')

    container_id=$(docker inspect $task_id \
        --format "{{ .Status.ContainerStatus.ContainerID }}" \
        | head -c 12)

    aws logs get-log-events \
        --log-group-name "$LOG_GROUP_NAME" \
        --log-stream-name "$LOG_STREAM_PREFIX-$container_id" \
        | jq -r .events[].message \
        > /dev/stderr
else
    echo "$status" > /dev/stderr
fi
