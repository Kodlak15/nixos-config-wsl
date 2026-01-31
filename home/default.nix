{
  pkgs,
  inputs,
  config,
  ...
}:
{
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "25.05";

    packages =
      with pkgs;
      [
        gcc
        ripgrep
        tree
        curl
        wget
        bat
        gh
        eza
      ]
      ++ [ inputs.nvim.packages."x86_64-linux".default ];
  };

  programs = {
    git = {
      enable = true;
      userName = "Kodlak15";
      userEmail = "stanlcod15@protonmail.com";
    };

    zsh = {
      enable = true;
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "lambda";
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
          };
        }
      ];

      initContent = ''
        export TERM=xterm-256color
        export ZELLIJ_AUTO_START=false

        # Fuzzy find and open a directory
        fzopen() {
        	directory="$(find * -type d | ${pkgs.fzf}/bin/fzf)"
        	if [[ -n "$directory" ]]; then
        	  cd "$directory"
          fi
        }

        # Fuzzy find and edit a file with neovim
        fzedit() {
        	file="$(${pkgs.fzf}/bin/fzf)"
        	if [[ -n "$file" ]]; then
        		nvim "$file"
        	fi
        }
      '';

      shellAliases = {
        tm = "tmux";
        o = "fzopen";
        e = "fzedit";
        nrb = "nixos-rebuild";
        nrbs = "nixos-rebuild switch";
        nb = "nix build";
        nr = "nix run";
        nd = "nix develop";
        ls = "eza -l";
        lsa = "eza -la";
      };
    };

    zellij = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        pane_frames = false;
        tab_bar = false;
        default_layout = "compact";
        theme = "ayu_dark";
        keybinds = {
          unbind = [
            "Ctrl p" # interferes with nvim binding
            "Ctrl n" # interferes with nvim binding
            "Ctrl o" # interferes with opencode binding
            "Ctrl t" # interferes with opencode binding
          ];
        };
        default_shell = "zsh";
        ui = {
          pane_frames = {
            hide_session_name = true;
          };
        };
        show_startup_tips = false;
        show_release_notes = false;
        themes = {
          ayu_dark = {
            text_unselected = {
              base = "#cccac2";
              background = "#131721";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#aad94c";
              emphasis_3 = "#d2a6ff";
            };
            text_selected = {
              base = "#cccac2";
              background = "#475266";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#aad94c";
              emphasis_3 = "#d2a6ff";
            };
            ribbon_selected = {
              base = "#131721";
              background = "#aad94c";
              emphasis_0 = "#f07178";
              emphasis_1 = "#ff8f40";
              emphasis_2 = "#d2a6ff";
              emphasis_3 = "#59c2ff";
            };
            ribbon_unselected = {
              base = "#131721";
              background = "#bfbdb6";
              emphasis_0 = "#f07178";
              emphasis_1 = "#cccac2";
              emphasis_2 = "#59c2ff";
              emphasis_3 = "#d2a6ff";
            };
            table_title = {
              base = "#aad94c";
              background = "#000000";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#aad94c";
              emphasis_3 = "#d2a6ff";
            };
            table_cell_selected = {
              base = "#cccac2";
              background = "#475266";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#aad94c";
              emphasis_3 = "#d2a6ff";
            };
            table_cell_unselected = {
              base = "#cccac2";
              background = "#131721";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#aad94c";
              emphasis_3 = "#d2a6ff";
            };
            list_selected = {
              base = "#cccac2";
              background = "#475266";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#aad94c";
              emphasis_3 = "#d2a6ff";
            };
            list_unselected = {
              base = "#cccac2";
              background = "#131721";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#aad94c";
              emphasis_3 = "#d2a6ff";
            };
            frame_selected = {
              base = "#aad94c";
              background = "#000000";
              emphasis_0 = "#ff8f40";
              emphasis_1 = "#73b8ff";
              emphasis_2 = "#d2a6ff";
              emphasis_3 = "#000000";
            };
            frame_highlight = {
              base = "#ff8f40";
              background = "#000000";
              emphasis_0 = "#d2a6ff";
              emphasis_1 = "#ff8f40";
              emphasis_2 = "#ff8f40";
              emphasis_3 = "#ff8f40";
            };
            exit_code_success = {
              base = "#aad94c";
              background = "#000000";
              emphasis_0 = "#73b8ff";
              emphasis_1 = "#131721";
              emphasis_2 = "#d2a6ff";
              emphasis_3 = "#59c2ff";
            };
            exit_code_error = {
              base = "#f07178";
              background = "#000000";
              emphasis_0 = "#e6b450";
              emphasis_1 = "#000000";
              emphasis_2 = "#000000";
              emphasis_3 = "#000000";
            };
            multiplayer_user_colors = {
              player_1 = "#d2a6ff";
              player_2 = "#59c2ff";
              player_3 = "#000000";
              player_4 = "#e6b450";
              player_5 = "#73b8ff";
              player_6 = "#000000";
              player_7 = "#f07178";
              player_8 = "#000000";
              player_9 = "#000000";
              player_10 = "#000000";
            };
          };
        };
      };
    };
  };
}
