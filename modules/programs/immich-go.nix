{ inputs, ... }:
{
  flake.modules.homeManager.immich-go =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      home.packages = with pkgs-unstable; [
        immich-go
      ];
    };
}
