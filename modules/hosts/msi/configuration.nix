{ inputs, ... }:
{
  flake.modules.nixos.msi =
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

          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-cpu-amd-zenpower
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd

          home-manager.nixosModules.home-manager

          hyprland
          desktop-apps
        ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/1320bab0-857c-411a-aede-51d8b375d030";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/9F9E-2BC7";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/mnt/storage" = {
        device = "/dev/disk/by-uuid/13ddf8d8-def6-467f-b487-1958633cf951";
        fsType = "ext4";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/89779217-c066-4c32-99cc-8928b72ba95f"; }
      ];

      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      networking = {
        hostName = "msi";
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

      hardware.graphics.enable = true;

      time.timeZone = "Europe/Paris";
      i18n.defaultLocale = "en_US.UTF-8";

      services.tailscale.enable = true;

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

      environment.systemPackages = [
        inputs.agenix.packages."x86_64-linux".default
      ];

      system.stateVersion = "25.05";
    };
}
