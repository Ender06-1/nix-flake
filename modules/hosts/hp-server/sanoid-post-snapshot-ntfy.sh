#!/usr/bin/env bash

curl \
  -H "Title: ZFS snapshot completed for ${SANOID_TARGETS}" \
  -H "Priority: default" \
  -H "Tags: white_check_mark,floppy_disk" \
  -d "Dataset: ${SANOID_TARGETS}
      Snapshot name: ${SANOID_SNAPNAMES}
      Snapshot type: ${SANOID_TYPES}" \
  https://ntfy.tailb1bb3f.ts.net/hdd-pool
