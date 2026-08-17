let
  serviceName = "tandoor";
  hostname = "${serviceName}.tailb1bb3f.ts.net";
in
{
  flake.modules.nixos.tandoor = {
    imports = [
      ./_compose.nix
    ];

    tandoor.enable = true;

    age.secrets.tandoor.file = ./_secrets/tandoor.age;

    services.caddy.virtualHosts.${hostname}.extraConfig = ''
      bind tailscale/${serviceName}
      tailscale_auth
      reverse_proxy localhost:8003
    '';
  };
}
