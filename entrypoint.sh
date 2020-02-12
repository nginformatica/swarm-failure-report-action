#!/bin/sh

set -eu

export GITHUB="true"

export INPUT_SHELL=$(cat /report-failures.sh)

export SERVICE_NAME=$INPUT_SERVICE_NAME
export LOG_GROUP_NAME=$INPUT_LOG_GROUP_NAME
export LOG_STREAM_PREFIX=$INPUT_LOG_STREAM_PREFIX

export INPUT_ENVS=LOG_GROUP_NAME,SERVICE_NAME

sh -c "/bin/drone-ssh $*"
