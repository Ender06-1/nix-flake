{ self, ... }:
{
  flake.modules.nixos.server = {
    imports = with self.modules.nixos; [
      base

      # agenix
      # caddy
      tailscale
    ];

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
