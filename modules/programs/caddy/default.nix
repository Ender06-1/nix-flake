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
          hash = "sha256-9/1L9s6dO35Bd8h/96DO2gY6akqXZ5aoPMsaXI5mDBw=";
        };
        environmentFile = config.age.secrets.caddy.path;
      };
    };
}
