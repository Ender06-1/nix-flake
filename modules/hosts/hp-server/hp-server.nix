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
          cockpit
          ntfy
          nextcloud
        ];

      boot = {
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "nvme"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [ "dm-snapshot" ];
          luks.devices.cryptroot.device = "/dev/disk/by-uuid/8018bf33-36e3-48e1-9075-f825bfb57512";
        };
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [ ];
        supportedFilesystems = [ "zfs" ];
        zfs = {
          forceImportRoot = false;
          extraPools = [ "tank" ];
        };
      };

      fileSystems = {
        "/" = {
          device = "/dev/mapper/rootvg-root";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/120A-A52F";
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

      environment.etc.crypttab.text = ''
        crypthdd1 UUID=16d1c857-0cd3-478e-9254-1a6b4ecafb40 /root/hdd1_keyfile.key
        crypthdd2 UUID=53ee822f-2ea6-48b1-a56a-6842b7ff746b /root/hdd2_keyfile.key
        crypthdd3 UUID=28eed261-09a6-4e71-82a8-f650e60e8348 /root/hdd3_keyfile.key
      '';

      networking.hostId = "4ae6ae4e";

      services.zfs = {
        autoScrub.enable = true;
        zed.settings = {
          ZED_NOTIFY_VERBOSE = 1;
          ZED_NTFY_URL = "https://ntfy.tailb1bb3f.ts.net";
          ZED_NTFY_TOPIC = "storage";
        };
      };

      services.smartd = {
        enable = true;
        autodetect = true;

        notifications = {
          mail = {
            enable = true;
            mailer = "${pkgs.writeShellScript "smartd-ntfy" ''
              ${pkgs.curl}/bin/curl  \
                -H "Title: SMARTD: ''${SMARTD_SUBJECT}" \
                -d "''${SMARTD_FAILTYPE} Device: ''${SMARTD_DEVICE} Time: ''${SMARTD_TFIRST} Message: ''${SMARTD_FULLMESSAGE}" \
                https://ntfy.tailb1bb3f.ts.net/hdd-pool
            ''}";
          };

          wall.enable = false;
          x11.enable = false;
        };
      };

      services.sanoid = {
        enable = true;
        templates."production" = {
          hourly = 24;
          daily = 15;
          monthly = 4;
          yearly = 2;

          autosnap = true;
          autoprune = true;

          pre_snapshot_script = "${./sanoid-pre-snapshot-ntfy.sh}";
          post_snapshot_script = "${./sanoid-post-snapshot-ntfy.sh}";
        };
        datasets = {
          "tank/old_data".use_template = [ "production" ];
          "tank/nextcloud".use_template = [ "production" ];
        };
      };

      console.keyMap = "us";
    };
}
