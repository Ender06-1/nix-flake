{
  flake.modules.homeManager.fish =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = false;
        interactiveShellInit = ''
          set fish_greeting
          set fish_color_autosuggestion brblack
          set fish_color_cancel --reverse
          set fish_color_command green --bold
          set fish_color_comment red
          set fish_color_cwd green
          set fish_color_cwd_root red
          set fish_color_end green
          set fish_color_error brred
          set fish_color_escape brcyan
          set fish_color_history_current --bold
          set fish_color_host normal
          set fish_color_host_remote yellow
          set fish_color_normal normal
          set fish_color_operator brcyan
          set fish_color_param cyan
          set fish_color_quote yellow
          set fish_color_redirection cyan --bold
          set fish_color_search_match white --background=brblack
          set fish_color_selection white --bold --background=brblack
          set fish_color_status red
          set fish_color_user brgreen
          set fish_color_valid_path --underline
        '';

        shellAliases = {
          nvimf = "nvim (fzf)";
        };

        functions = {
          ltg = "lt --git-ignore -a";
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

    };
}
