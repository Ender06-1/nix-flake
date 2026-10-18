#!/usr/bin/env bash

curl \
  -H "Title: ZFS snapshot starting for ${SANOID_TARGETS}" \
  -H "Priority: default" \
  -H "Tags: hourglass,floppy_disk" \
  -d "Dataset: ${SANOID_TARGETS}
      Snapshot name: ${SANOID_SNAPNAMES}
      Snapshot type: ${SANOID_TYPES}" \
  https://ntfy.tailb1bb3f.ts.net/hdd-pool
