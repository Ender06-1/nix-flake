{
  flake.modules.nixos.caddy =
    { config, pkgs, ... }:
    {
      age.secrets = {
        caddy.file = ./_secrets/caddy.age;
      };

      services.caddy = {
        enable = true;

        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac" ];
          hash = "sha256-tP/ZQjZvfb+e3322dzd3I89Y9QwujcyqV1fbNWyw08g=";
        };
        environmentFile = config.age.secrets.caddy.path;
      };
    };
}
