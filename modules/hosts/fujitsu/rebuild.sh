#!/usr/bin/env bash

FLAKE_PATH="$HOME/nixos-config"

HOST_CONFIG="$FLAKE_PATH#fujitsu"
HOST=admin@192.168.0.2

nixos-rebuild switch \
	--flake "$HOST_CONFIG" \
	--target-host "$HOST" --build-host "$HOST" \
	--sudo --ask-sudo-password
