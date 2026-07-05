let
  serviceName = "filebrowser";
  hostname = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.filebrowser = {
    imports = [
      ./_compose.nix
    ];

    filebrowser.enable = true;

    services.caddy = {
      virtualHosts.${hostname}.extraConfig = ''
        bind tailscale/${serviceName}
        tailscale_auth
        reverse_proxy localhost:8000
      '';
    };

    systemd.tmpfiles.rules = [
      "d /var/stacks/${serviceName} 0755 admin users -"
      "C /var/stacks/${serviceName}/data 0755 admin users - ${./data}"
    ];
  };

}
