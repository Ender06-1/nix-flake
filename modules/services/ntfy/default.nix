let
  serviceName = "ntfy";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = {
    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/ntfy
      tailscale_auth
      reverse_proxy http://127.0.0.1:8001
    '';

    systemd.tmpfiles.rules = [
      "d /var/cache/ntfy 0700 admin users -"
    ];
  };
}
