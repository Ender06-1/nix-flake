{
  flake.modules.homeManager.minecraft =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        jdk25_headless
        prismlauncher
        ftb-app
      ];
    };
}
