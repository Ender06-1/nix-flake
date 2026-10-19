let
  serviceName = "immich";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = {
    imports = [
      ./_compose.nix
    ];

    age.secrets.immich.file = ./_secrets/immich.age;

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/immich
      tailscale_auth
      reverse_proxy 127.0.0.1:8004
    '';
  };
}
