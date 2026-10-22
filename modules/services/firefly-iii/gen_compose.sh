#!/usr/bin/env bash

set -exu

sudo compose2nix -check_bind_mounts -output _compose.nix -root_path /srv/tank/firefly-iii -runtime docker -env_files /run/agenix/firefly-iii-app,/run/agenix/firefly-iii-db -env_files_only
