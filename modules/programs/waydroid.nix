{
  flake.modules.nixos.waydroid =
    { pkgs, ... }:
    {
      virtualisation.waydroid.enable = true;

      environment.systemPackages = with pkgs; [
        wl-clipboard
      ];
    };
}
