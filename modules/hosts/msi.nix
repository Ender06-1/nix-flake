{ inputs, self, ... }:
let
  hostname = "msi";
in
{
  flake.nixosConfigurations = self.lib.mkNixos "x86_64-linux" hostname;

  flake.modules.nixos.${hostname} =
    {
      config,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports =
        with inputs;
        with self.modules.nixos;
        with inputs.nixos-hardware.nixosModules;
        [
          (modulesPath + "/installer/scan/not-detected.nix")
          common-cpu-amd
          # common-cpu-amd-zenpower
          common-gpu-amd
          common-pc
          common-pc-ssd

          # Roles
          desktop
          hyprland

          # Specific programs/services
          tailscale
          agenix

          # Users
          matheo
        ];

      boot = {
        initrd = {
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ "dm-snapshot" ];
          luks.devices.cryptroot.device = "/dev/disk/by-uuid/72771b81-de72-46dd-bdfb-421b5ec38069";
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/mapper/rootvg-root";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/2819-C9A8";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      swapDevices = [
        { device = "/dev/mapper/rootvg-swap"; }
      ];

      console.keyMap = "us";
    };
}
