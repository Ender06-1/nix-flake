{
  flake.modules.homeManager.tmux = { pkgs, ... }: {
    programs.tmux = {
      enable = true;

      clock24 = true;
      mouse = true;
      resizeAmount = 10;
      shortcut = "s";
      keyMode = "vi";
      escapeTime = 300;
      focusEvents = true;
      terminal = "tmux-256color";

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = onedark-theme.overrideAttrs (old: {
            postInstall =
              (old.postInstall or "")
              + ''
                sed -i '1s|#!/bin/bash|#!/usr/bin/env bash|' $out/share/tmux-plugins/onedark-theme/tmux-onedark-theme.tmux
              '';
            });
        }
      ];
    };
  };
}

