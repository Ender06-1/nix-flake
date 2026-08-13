{ inputs, ... }:
{
  flake.modules.homeManager.neovim =
    { config, pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      programs.neovim = {
        enable = true;
        package = pkgs-unstable.neovim-unwrapped;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        sideloadInitLua = true;

        withNodeJs = false;
        withPython3 = false;
        withRuby = false;

        extraPackages = with pkgs; [
          curl
          git

          gcc
          lua
          luarocks
          lua-language-server
          stylua

          ripgrep
          fd
          wl-clipboard

          fzf
        ];
      };

      home.packages = with pkgs; [
        wl-clipboard
      ];

      xdg = {
        configFile."nvim".source = config.lib.my.mkConfigSym "programs/neovim/config";
        mimeApps.defaultApplicationPackages = [ pkgs.neovim-unwrapped ];
      };

    };
}
