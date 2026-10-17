let
  serviceName = "cockpit";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = { lib, ... }: {
    services.cockpit = {
      enable = true;
      port = 8000;
      settings = {
        WebService = {
          Origins = lib.mkForce "https://${domain}";
          ProtocolHeader = "X-Forwarded-Proto";
        };
      };
    };

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/cockpit
      tailscale_auth
      reverse_proxy 127.0.0.1:8000
    '';
  };
}
