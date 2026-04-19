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
        onedark-theme
      ];
    };
  };
}

