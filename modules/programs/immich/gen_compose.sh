#!/usr/bin/env bash

set -exu

sudo compose2nix -enable_option -output _compose.nix -root_path /var/stacks/immich -runtime docker --env_files=/run/agenix/immich --include_env_files=true
