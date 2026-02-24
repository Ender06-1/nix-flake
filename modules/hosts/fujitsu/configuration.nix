{ inputs, ... }:
{
  flake.modules.nixos.fujitsu =
    { pkgs, ... }:
    {
      imports = [
        ./hardware-configuration.nix

        ./services/ssh.nix

        inputs.agenix.nixosModules.default
        ./modules/agenix.nix

        ./services/tailscale.nix
        ./services/caddy.nix

        ./modules/docker.nix

        ./services/dockge.nix
        ./services/homarr.nix
        ./services/filebrowser.nix
        ./services/pihole.nix
        ./services/dash.nix
        ./services/immich.nix
      ];

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
        extraGroups = [ "wheel" ];

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

      system.stateVersion = "25.11";
    };
}
