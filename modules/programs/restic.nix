{
  flake.modules.homeManager.restic = { pkgs, ... }: {
    home.packages = with pkgs; [
      restic
    ];
  };
}
