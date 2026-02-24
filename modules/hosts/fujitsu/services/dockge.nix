{ ... }:
let
  hostname = "dockge.tailb1bb3f.ts.net";
in
{
  services.caddy.virtualHosts.${hostname}.extraConfig = ''
    bind tailscale/dockge
    tailscale_auth
    reverse_proxy 127.0.0.1:8000
  '';
}
