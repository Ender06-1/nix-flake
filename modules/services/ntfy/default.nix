let
  serviceName = "ntfy";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = {
    imports = [
      ./_compose.nix
    ];

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/ntfy
      tailscale_auth
      reverse_proxy http://127.0.0.1:8001
    '';

    systemd.tmpfiles.rules = [
      "d /var/stacks/ntfy/cache 0700 admin users -"
    ];
  };
}
