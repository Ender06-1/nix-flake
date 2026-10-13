{ inputs, self, ... }:
let
  hostname = "framework";
in
{
  flake.nixosConfigurations = self.lib.mkNixos "x86_64-linux" hostname;

  flake.modules.nixos.${hostname} =
    { modulesPath, ... }:
    {
      imports =
        with self.modules.nixos;
        with inputs.nixos-hardware.nixosModules;
        [
          (modulesPath + "/installer/scan/not-detected.nix")
          framework-13th-gen-intel

          # Roles
          laptop
          hyprland

          # Specific programs/services
          tailscale

          # Users
          matheo
        ];

      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "thunderbolt"
            "nvme"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];
          kernelModules = [ "dm-snapshot" ];
          luks.devices.cryptroot.device = "/dev/disk/by-uuid/815617d8-950b-4eab-8bf5-dd588ff0808b";
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/mapper/rootvg-root";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/5879-E087";
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
