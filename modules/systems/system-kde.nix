{ self, ... }:
{
  flake.modules.nixos.system-kde = {
    imports = with self.modules.nixos; [
      system-desktop
    ];

    home-manager.sharedModules = with self.modules.homeManager; [
      system-kde
    ];

    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.system-kde =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        papirus-icon-theme

        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
      ];
    };
}
