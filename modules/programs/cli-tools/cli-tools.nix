{
  flake.modules.homeManager.cli-tools =
    { pkgs, ... }:
    {
      programs.bat.enable = true;

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.eza = {
        enable = true;
        colors = "always";
        icons = "always";
        extraOptions = [
          "--hyperlink"
          "--group-directories-first"
          "--smart-group"
          "--header"
        ];
      };

      programs.git = {
        enable = true;
        settings = {
          init = {
            defaultBranch = "main";
          };
          user = {
            name = "Mathéba";
            email = "ndxendernight@gmail.com";
          };
        };
      };

      programs.yazi = {
        enable = true;
        shellWrapperName = "y";
      };

      programs.zoxide.enable = true;

      home.packages = with pkgs; [
        fzf
        btop
        fastfetch
        wget
        file
        ffmpeg
        p7zip
        jq
        resvg
        imagemagick
        wl-clipboard
        unzip
        zip
      ];
    };
}
