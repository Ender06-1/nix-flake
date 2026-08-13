let
  serviceName = "immich";
  hostname = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.immich = {
    imports = [
      ./_compose.nix
    ];

    immich.enable = true;

    age.secrets.immich.file = ./_secrets/immich.age;

    services.caddy.virtualHosts.${hostname}.extraConfig = ''
      bind tailscale/${serviceName}
      tailscale_auth
      reverse_proxy localhost:8001
    '';

    systemd.tmpfiles.rules = [
      "d /var/stacks/${serviceName} 0755 admin users -"
    ];
  };
}
