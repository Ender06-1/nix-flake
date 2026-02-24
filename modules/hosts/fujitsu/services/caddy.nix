{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20251204171825-f070d146dd61" ];
      hash = "sha256-cK7C5ISsTwX0FMf891s/Vr22JvRqYEC8GkLfP1L1Mus=";
    };
    environmentFile = config.age.secrets.caddy.path;
  };
}
