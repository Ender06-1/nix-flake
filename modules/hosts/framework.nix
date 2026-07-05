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
          hyprland
          laptop

          # Specific programs/services
          tailscale
          virtualisation

          # Users
          matheo
        ];

      home-manager.sharedModules = with self.modules.homeManager; [
        framework
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
          kernelModules = [ ];
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/87f36fab-3d52-434f-af4c-ed9f30569981";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/E6FF-1223";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/f1b2f53b-bb38-4073-b750-6fa555de0c64"; }
      ];

      console.keyMap = "us";
    };

  flake.modules.homeManager.${hostname} = { lib, ... }: {
    programs.caelestia.settings.bar.status.showBattery = lib.mkForce true;
  };
}
