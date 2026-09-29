{ self, ... }: {
  flake.modules.nixos.laptop = {
    imports = with self.modules.nixos; [
      desktop
    ];

    services = {
      power-profiles-daemon.enable = true;
      thermald.enable = true;
    };
  };
}
