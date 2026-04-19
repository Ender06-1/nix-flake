{
  flake.modules.homeManager.fish = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      generateCompletions = false;
      interactiveShellInit = ''
        set fish_greeting
      '';
      
      shellAliases = {
        nvimf = "nvim (fzf)";
      };
    };
      
    programs.starship = {
      enable = true;
      enableTransience = true;
      enableBashIntegration = false;
    };
      
    programs.bash = {
      enable = true;
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    
    xdg = {
      enable = true;
      configFile = {
        "fish/conf.d" = {
          source = ./config/fish/conf.d;
          recursive = true;
        };
        "fish/functions" = {
          source = ./config/fish/functions;
          recursive = true;
        };
        "starship.toml".source = ./config/starship.toml;
      };
    };
  };
}
