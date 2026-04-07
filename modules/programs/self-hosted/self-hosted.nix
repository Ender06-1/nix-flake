{
  flake.modules.homeManager.self-hosted =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        affine
      ];
    };
}
