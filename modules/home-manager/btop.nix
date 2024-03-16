{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
  };
  xdg.configFile = {
    "btop/themes/catppuccin_mocha.theme".source = ./btop.theme;
  };
}
