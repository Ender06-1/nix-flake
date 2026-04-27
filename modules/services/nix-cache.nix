{
  flake.modules.nixos.nix-cache =
    { config, ... }:
    {
      services.nix-serve = {
        enable = true;
        secretKeyFile = "/var/cache-priv-key.pem";
      };

      services.caddy = {
        virtualHosts."nix-cache.tailb1bb3f.ts.net".extraConfig = ''
          bind tailscale/nix-cache
          tailscale_auth
          reverse_proxy http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}
        '';
      };
    };
}
