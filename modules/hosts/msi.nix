{ inputs, self, ... }:
let
  hostname = "msi";
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
          common-cpu-amd
          common-cpu-amd-zenpower
          common-gpu-amd
          common-pc
          common-pc-ssd

          system-hyprland

          # Specific programs/services
          tailscale
          virtualisation

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
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/1320bab0-857c-411a-aede-51d8b375d030";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/9F9E-2BC7";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        "/mnt/storage" = {
          device = "/dev/disk/by-uuid/13ddf8d8-def6-467f-b487-1958633cf951";
          fsType = "ext4";
        };
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/89779217-c066-4c32-99cc-8928b72ba95f"; }
      ];
    };
}
