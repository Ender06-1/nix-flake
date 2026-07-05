#! /usr/bin/env bash

HOST=admin@fujitsu
FLAKE_PATH=.#fujitsu

nixos-rebuild switch --flake "$FLAKE_PATH" --target-host "$HOST" --build-host "$HOST" --sudo --ask-sudo-password
