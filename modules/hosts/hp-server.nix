{ inputs, self, ... }:
let
  hostname = "hp-server";
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
        ];

      boot = {
        initrd = {
          availableKernelModules = [
	  
   "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"
          ];
          kernelModules = [ "dm-snapshot" ];
  luks.devices.cryptroot.device = "/dev/disk/by-uuid/8018bf33-36e3-48e1-9075-f825bfb57512";
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };
  fileSystems = {
  "/" =
    { device = "/dev/mapper/rootvg-root";
      fsType = "ext4";
    };

  "/boot" =
    { device = "/dev/disk/by-uuid/120A-A52F";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices =
    [ { device = "/dev/mapper/rootvg-swap"; }
    ];

      console.keyMap = "us";
    };
}
