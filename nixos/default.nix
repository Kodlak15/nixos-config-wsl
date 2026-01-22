{ pkgs, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs = {
    zsh.enable = true;
  };

  time.timeZone = "US/Pacific";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    shells = with pkgs; [ zsh ];
  };

  users = {
    users.kodlak = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPassword = "$y$j9T$w04YAfRbj6NhbRTNx479d.$mLXI5z2pOeSSsg6nYfyhuGtVK.0HhX0SW6i/d.7btJ/";
    };

    defaultUserShell = pkgs.zsh;
  };
}
