{ lib, config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    extraConfig = {
      modi = "run,drun,filebrowser";
      icon-theme = "Oranchelo";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-filebrowser = "   FileBrowser";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };
    theme = ./theme.rafi;
  };
}
