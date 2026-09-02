{
  flake.modules.homeManager.kolourpaint = { pkgs, ... }: {
    home.packages = with pkgs; [
      kdePackages.kolourpaint
    ];
  };
}
