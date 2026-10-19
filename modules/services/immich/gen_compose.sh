#!/usr/bin/env bash

set -exu

sudo compose2nix -check_bind_mounts -output _compose.nix -root_path /var/stacks/immich -runtime docker -env_files /run/agenix/immich -env_files_only
