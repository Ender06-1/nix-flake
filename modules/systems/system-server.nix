{ self, ... }:
{
  flake.modules.nixos.system-server = {
    imports = with self.modules.nixos; [
      system-default

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
