{ lib, config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [pkgs.rofi-emoji];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    extraConfig = {
      modi = "run,drun,emoji";
      icon-theme = "BeautyLine";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-filebrowser = "   FileBrowser";
      display-emoji = "❁ Emoji";
      sidebar-mode = true;
    };
    theme = ./theme.rafi;
  };
}
