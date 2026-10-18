#!/usr/bin/env bash

set -exu

compose2nix -check_bind_mounts -output _compose.nix -root_path /var/stacks/nextcloud -runtime docker
