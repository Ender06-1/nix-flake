let
  serviceName = "uptime-kuma";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = {
    imports = [
      ./_compose.nix
    ];

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/${serviceName}
      tailscale_auth
      reverse_proxy 127.0.0.1:8006
    '';
  };
}
