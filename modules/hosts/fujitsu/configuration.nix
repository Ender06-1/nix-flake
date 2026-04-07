{ ... }:
{
  flake.modules.nixos.fujitsu =
    {
      lib,
      config,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

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

      swapDevices = [
        { device = "/dev/disk/by-uuid/7458e041-e94f-463a-97ab-2dd9cbdfc961"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        swraid = {
          enable = true;
          mdadmConf = ''
            MAILADDR ndxendernight@gmail.com

            DEVICE partitions
            ARRAY /dev/md127 metadata=1.2 UUID=b38c2ca5:505e5f6a:18e76936:e5a7ac4d
          '';
        };
        tmp.cleanOnBoot = true;
      };

      fileSystems."/mnt/storage" = {
        device = "/dev/disk/by-uuid/44ee60cd-e543-4cca-9278-8947bcb2ebcd";
        fsType = "ext4";
      };

      nix = {
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        gc = {
          automatic = true;
          dates = "23:00";
        };
      };
      nixpkgs.config.allowUnfree = true;

      networking = {
        hostName = "fujitsu";
        interfaces.enp2s0 = {
          ipv4.addresses = [
            {
              address = "192.168.0.2";
              prefixLength = 24;
            }
          ];
        };
        defaultGateway = {
          address = "192.168.0.1";
          interface = "enp2s0";
        };
        nameservers = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };

      time.timeZone = "Europe/Paris";
      i18n.defaultLocale = "en_US.UTF-8";
      console.keyMap = "us";

      users.users."admin" = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "docker"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPybOZB+lmPWgxHv5boGPtlMz6QQ8T881/Yzbk/M36z"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILa6CxEhvFFvpusrhmmAvhv8Pt0gm3Zz0SV7w1os1J54"
        ];
      };

      environment.systemPackages = with pkgs; [
        neovim
        git
        btop
        tree
        wget
        mdadm
        fastfetch
        restic
      ];

      virtualisation.docker.enable = true;

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          AllowUsers = [ "admin" ];
        };
      };

      services.tailscale.enable = true;

      services.caddy = {
        enable = true;
        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac" ];
          hash = "sha256-1BAY6oZ1qJCKlh0Y2KKqw87A45EUPVtwS2Su+LfXtCc=";
        };
        environmentFile = config.age.secrets.caddy.path;
      };

      age.secrets.caddy.file = ./_secrets/caddy.age;

      services.caddy.virtualHosts."homepage.tailb1bb3f.ts.net".extraConfig = ''
        bind tailscale/homepage
        tailscale_auth
        reverse_proxy 127.0.0.1:8000
      '';

      services.caddy.virtualHosts."filebrowser.tailb1bb3f.ts.net".extraConfig = ''
        bind tailscale/filebrowser
        tailscale_auth
        reverse_proxy 127.0.0.1:8001
      '';

      services.caddy.virtualHosts."fireflyiii.tailb1bb3f.ts.net".extraConfig = ''
        bind tailscale/fireflyiii
        tailscale_auth
        reverse_proxy 127.0.0.1:8002
      '';

      services.caddy.virtualHosts."nextcloud.tailb1bb3f.ts.net".extraConfig = ''
        bind tailscale/nextcloud
        tailscale_auth
        reverse_proxy 127.0.0.1:8003
      '';

      services.caddy.virtualHosts."immich.tailb1bb3f.ts.net".extraConfig = ''
        bind tailscale/immich
        tailscale_auth
        reverse_proxy 127.0.0.1:8004
      '';

      services.caddy.virtualHosts."affine.tailb1bb3f.ts.net".extraConfig = ''
        bind tailscale/affine
        tailscale_auth
        reverse_proxy 127.0.0.1:8005
      '';

      system.stateVersion = "25.11";
    };
}
