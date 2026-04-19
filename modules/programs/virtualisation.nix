{
  flake.modules.nixos.virtualisation =
    { pkgs, ... }:
    {
      virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
      };

      virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      };
      programs.virt-manager.enable = true;

      environment.systemPackages = with pkgs; [
        dnsmasq
      ];
    };
}
