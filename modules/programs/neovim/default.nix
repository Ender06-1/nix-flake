{ inputs, ... }:
{
  flake.modules.homeManager.neovim = { pkgs, ... }:
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
      enable = true;
      configFile = {
        "nvim" = {
          source = ./config/nvim;
          recursive = true;
        };
      };
      mimeApps = {
        enable = true;
        defaultApplicationPackages = [ pkgs.neovim-unwrapped ];
      };
    };
  };
}
