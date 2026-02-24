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
        device = "/dev/disk/by-uuid/55a93207-ba33-44e5-8967-f3beab8ae5dc";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1892-2E92";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/7f7fce8f-e5de-4308-baf5-a1acb34e0202"; }
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
            ARRAY /dev/md127 metadata=1.2 UUID=10972912:7dbdf640:0347c360:18fb2100
          '';
        };
        tmp.cleanOnBoot = true;
      };

      fileSystems."/mnt/storage" = {
        device = "/dev/disk/by-uuid/2a99cbd5-b3a6-495e-89d4-ed357b432a89";
        fsType = "ext4";
      };

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

      nix.settings.trusted-users = [ "admin" ];
      nixpkgs.config.allowUnfree = true;

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
        ];
      };

      environment.systemPackages = with pkgs; [
        neovim
        git
        btop
        tree
        wget
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
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20251204171825-f070d146dd61" ];
          hash = "sha256-cK7C5ISsTwX0FMf891s/Vr22JvRqYEC8GkLfP1L1Mus=";
        };
      };

      services.caddy.virtualHosts."dockge.tailb1bb3f.ts.net".extraConfig = ''
        bind tailscale/dockge
        tailscale_auth
        reverse_proxy 127.0.0.1:8000
      '';

      system.stateVersion = "25.11";
    };
}
