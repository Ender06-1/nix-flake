{ self, ... }:
{
  flake.modules.nixos.kde = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      desktop
    ];

    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      papirus-icon-theme

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];
  };
}
