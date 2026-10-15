{
  flake.modules.homeManager.zfs = { pkgs, ... }: {
    home.packages = with pkgs; [
      zfs
    ];
  };
}
