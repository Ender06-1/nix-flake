{ self, ... }:
{
  flake.modules.nixos.server = {
    imports = with self.modules.nixos; [
      base

      tailscale
      agenix
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
