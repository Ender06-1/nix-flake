let
  serviceName = "filebrowser";
  hostname = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.filebrowser =
    { config, ... }:
    {
      imports = [
        ./_filebrowser_compose.nix
      ];

      services.caddy = {
        virtualHosts.${hostname}.extraConfig = ''
          bind tailscale/${serviceName}
          tailscale_auth
          reverse_proxy localhost:8000
        '';
      };

      systemd.tmpfiles.rules = [
        "d /var/lib/${serviceName} 0755 admin 1000 -"
        "C /var/lib/${serviceName}/data 0755 admin 1000 - ${./data}"
      ];
    };
}
