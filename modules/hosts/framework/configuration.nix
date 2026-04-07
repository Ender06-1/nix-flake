{ inputs, ... }:
{
  flake.modules.nixos.framework =
    {
      lib,
      config,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports =
        with inputs;
        with inputs.self.modules.nixos;
        [
          (modulesPath + "/installer/scan/not-detected.nix")

          nixos-hardware.nixosModules.framework-13th-gen-intel
          home-manager.nixosModules.home-manager

          hyprland-laptop
          desktop-apps
          self-hosted
        ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/87f36fab-3d52-434f-af4c-ed9f30569981";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/E6FF-1223";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/f1b2f53b-bb38-4073-b750-6fa555de0c64"; }
      ];

      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      networking = {
        hostName = "framework";
        networkmanager.enable = true;
      };

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        kernelPackages = pkgs.linuxPackages_zen;

        tmp.cleanOnBoot = true;
      };

      console.keyMap = "us";

      services.logind.settings.Login = {
        HandlePowerKey = "suspend";
      };

      hardware = {
        graphics.enable = true;
        intel-gpu-tools.enable = true;
      };

      time.timeZone = "Europe/Paris";
      i18n.defaultLocale = "en_US.UTF-8";

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

      hardware.bluetooth = {
        enable = true;
        settings = {
          General = {
            Expermental = true;
          };
        };
      };

      programs.ssh = {
        startAgent = true;
        extraConfig = ''
          AddKeysToAgent yes
        '';
      };

      services.flatpak.enable = true;

      users.users.matheo = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "docker"
          "kvm"
          "libvirtd"
        ];
      };

      home-manager.users.matheo =
        { pkgs, ... }:
        {
          imports = with inputs.self.modules.homeManager; [
            inputs.caelestia-shell.homeManagerModules.default

            browser
            neovim
            shell
            cli-tools
            tmux
            self-hosted
          ];

          home.username = "matheo";
          home.homeDirectory = "/home/matheo";

          home.packages = with pkgs; [
            jdk25_headless
            prismlauncher
            ftb-app
          ];

          home.stateVersion = "25.05";
        };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
      };

      virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
      };

      services = {
        udisks2.enable = true;
        gvfs.enable = true;
      };

      system.stateVersion = "25.05";
    };
}
