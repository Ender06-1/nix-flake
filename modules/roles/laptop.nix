{ self, ... }: {
  flake.modules.nixos.laptop = {
    imports = with self.modules.nixos; [
      base
    ];

    services = {
      power-profiles-daemon.enable = true;
      thermald.enable = true;
    };
  };
}
