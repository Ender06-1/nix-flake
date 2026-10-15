{
  flake.modules.homeManager.hdparm = { pkgs, ... }: {
    home.packages = with pkgs; [
      hdparm
    ];
  };
}
