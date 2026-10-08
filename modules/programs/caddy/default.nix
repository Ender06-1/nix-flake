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
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260826180304-de41b249af4f" ];
          hash = "sha256-IzLM8Qgxurrgs6NBygGEGyzXQUxQMPP3Y6iIWVN5ZvQ=";
        };
        environmentFile = config.age.secrets.caddy.path;
      };
    };
}
