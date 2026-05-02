{
  flake.modules.homeManager.compose2nix =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        compose2nix
      ];
    };
}
