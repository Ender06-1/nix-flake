#!/usr/bin/env bash

set -exu

compose2nix -enable_option -output _compose.nix -root_path /var/stacks/filebrowser -runtime docker
