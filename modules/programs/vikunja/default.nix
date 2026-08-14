let
  serviceName = "vikunja";
  hostname = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.vikunja = {
    imports = [
      ./_compose.nix
    ];

    vikunja.enable = true;

    services.caddy.virtualHosts.${hostname}.extraConfig = ''
      bind tailscale/${serviceName}
      tailscale_auth
      reverse_proxy localhost:8002
    '';
  };

}
