{
  flake.modules.nixos.caddy =
    { config, pkgs, ... }:
    {
      services.caddy = {
        enable = true;

        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac" ];
          hash = "sha256-XBdYjtuPVu/beIgFgFcVp6ln4r9kq0B6+4xJ8+WWYn0=";
        };
        environmentFile = config.age.secrets.caddy.path;
      };
    };
}
