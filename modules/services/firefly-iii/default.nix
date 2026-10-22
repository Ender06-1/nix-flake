let
  serviceName = "firefly-iii";
  domain = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.${serviceName} = {
    imports = [
      ./_compose.nix
    ];

    age.secrets = {
      firefly-iii-app.file = ./_secrets/firefly-iii-app.age;
      firefly-iii-db.file = ./_secrets/firefly-iii-db.age;
    };

    services.caddy.virtualHosts.${domain}.extraConfig = ''
      bind tailscale/${serviceName}
      tailscale_auth
      reverse_proxy 127.0.0.1:8007
    '';
  };
}
