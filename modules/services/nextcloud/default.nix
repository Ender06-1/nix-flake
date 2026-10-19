let
  serviceName = "nextcloud";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = {
    imports = [
      ./_compose.nix
    ];

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/nextcloud
      tailscale_auth
      reverse_proxy 127.0.0.1:8003
    '';
  };
}
