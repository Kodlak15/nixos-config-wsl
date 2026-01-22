{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "lambda";
    };

    autosuggestions = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };

    shellAliases = {
      tm = "tmux";
      o = "fzopen";
      e = "fzedit";
      nrb = "nixos-rebuild";
      nrbs = "nixos-rebuild switch";
      nb = "nix build";
      nr = "nix run";
      nd = "nix develop";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";

    # initContent = ''
    loginShellInit = ''
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
  };
}
