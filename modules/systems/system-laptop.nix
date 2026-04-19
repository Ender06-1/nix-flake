{ self, ... }: {
  flake.modules.nixos.system-laptop = {
    imports = with self.modules.nixos; [
      system-desktop
    ];

    services = {
      power-profiles-daemon.enable = true;
      thermald.enable = true;
    };
  };
}
