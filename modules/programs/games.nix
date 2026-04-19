{ self, ... }:
{
  flake.modules.nixos.games = {
    home-manager.sharedModules = with self.modules.homeManager; [
      games
    ];

    programs.steam.enable = true;
  };

  flake.modules.homeManager.games =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jdk25_headless
        prismlauncher
        ftb-app
      ];
    };
}
