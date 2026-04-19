{
  flake.modules.homeManager.kitty =
    { pkgs, ... }:
    {
      programs.kitty = {
        enable = true;
        themeFile = "OneDark-Pro";
        font.name = "FiraCode Nerd Font";
      };

      fonts.fontconfig.enable = true;

      home.packages = with pkgs; [
        nerd-fonts.fira-code
      ];
    };
}
