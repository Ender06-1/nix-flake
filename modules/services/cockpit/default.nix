{ inputs, ... }:
let
  serviceName = "cockpit";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{

  flake.modules.nixos.${serviceName} =
    { lib, pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      services.cockpit = {
        enable = true;
        port = 8000;
        plugins = with pkgs-unstable; [
          cockpit-podman
          cockpit-files
          cockpit-zfs
        ];
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
