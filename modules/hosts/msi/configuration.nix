{ inputs, self, ... }:
let
  hostname = "msi";
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
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports =
        with inputs;
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

          agenix.nixosModules.default
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

      console.keyMap = "us";

      environment.systemPackages = with inputs; [
        agenix.packages.${system}.default
      ];

      age = {
        identityPaths = [ "/home/matheo/.ssh/id_ed25519" ];
        secrets.caddy.file = ./_secrets/caddy.age;
      };

      services.nix-serve = {
        enable = true;
        secretKeyFile = "/var/cache-priv-key.pem";
      };

      services.caddy = {
        enable = true;
        package = pkgs.caddy.withPlugins {
          plugins = [ "github.com/tailscale/caddy-tailscale@v0.0.0-20260106222316-bb080c4414ac" ];
          hash = "sha256-Uzl5e3WHrIQxSScgZmBhBq4VNavxU+MHr2nT5xG6XbU=";
        };
        environmentFile = config.age.secrets.caddy.path;
        virtualHosts."nix-cache.tailb1bb3f.ts.net".extraConfig = ''
          bind tailscale/nix-cache
          tailscale_auth
          reverse_proxy http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}
        '';
      };
    };
}
