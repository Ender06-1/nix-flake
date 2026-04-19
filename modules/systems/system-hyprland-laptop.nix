{ self, ... }: {
  flake.modules.nixos.system-hyprland-laptop = {
    imports = with self.modules.nixos; [
      system-hyprland
      system-laptop
    ];

    home-manager.sharedModules = with self.modules.homeManager; [
      system-hyprland-laptop
    ];
  };

  flake.modules.homeManager.system-hyprland-laptop = { lib, ... }: {
    programs.caelestia = {
      settings = {
        bar.status.showBattery = lib.mkForce true;
      };
    };
  };
}
