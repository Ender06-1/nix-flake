{ inputs, self, ... }:
let
  hostname = "fujitsu";
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

          # Roles
          server

          # Users
          admin

          # Services
          filebrowser
          immich
        ];

      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ehci_pci"
            "ahci"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/34590a90-0083-4543-9d82-ed0b5574421d";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/0CFE-5152";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      boot.swraid = {
        enable = true;
        mdadmConf = ''
          MAILADDR ndxendernight@gmail.com

          DEVICE partitions
          ARRAY /dev/md127 metadata=1.2 UUID=b38c2ca5:505e5f6a:18e76936:e5a7ac4d
        '';
      };

      fileSystems."/mnt/storage" = {
        device = "/dev/disk/by-uuid/44ee60cd-e543-4cca-9278-8947bcb2ebcd";
        fsType = "ext4";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/7458e041-e94f-463a-97ab-2dd9cbdfc961"; }
      ];

      console.keyMap = "us";
    };
}
