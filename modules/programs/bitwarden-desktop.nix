{
  flake.modules.homeManager.bitwarden-desktop = { pkgs, ... }: {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];
  };
}
