{
  flake.modules.nixos.caddy =
    { config, pkgs, ... }:
    {
      services.caddy = {
        enable = true;

        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac" ];
          hash = "sha256-Uzl5e3WHrIQxSScgZmBhBq4VNavxU+MHr2nT5xG6XbU=";
        };
        environmentFile = config.age.secrets.caddy.path;
      };
    };
}
