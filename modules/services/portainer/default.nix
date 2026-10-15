let
  serviceName = "portainer";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = {
    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/portainer
      tailscale_auth
      reverse_proxy http://127.0.0.1:8000
    '';
  };
}
