{ inputs, self, ... }:
let
  hostname = "thinkpad";
  hardware = inputs.nixos-hardware;
in
{
  flake.nixosConfigurations = self.lib.mkNixos "x86_64-linux" hostname;

  flake.modules.nixos.${hostname} =
    {
      config,
      pkgs,
      modulesPath,
      lib,
      ...
    }:
    {

      imports =
        with inputs;
        with self.modules.nixos;
        [
          (modulesPath + "/installer/scan/not-detected.nix")
          "${hardware}/common/cpu/intel/kaby-lake"
          "${hardware}/common/pc/laptop"
          "${hardware}/common/pc/ssd"

          # Roles
          kde

          # Users
          matheo
          rumicorne
        ];

      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "nvme"
            "usb_storage"
            "sd_mod"
            "sdhci_pci"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/3181d911-5d50-4dd8-9f0f-c9e9cbf66442";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/003E-A9F3";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/471d4cab-3bf7-4fa3-b378-acb760b7c658"; }
      ];

      console.keyMap = "us";
    };
}
