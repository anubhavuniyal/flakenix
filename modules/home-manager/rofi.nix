{ lib, config, pkgs, ... }:
{
  programs.rofi = {
  	enable = true;
	package = pkgs.rofi-wayland;
	terminal = "${pkgs.alacritty}/bin/alacritty";
	extraConfig = {
	modi= "run,drun,window";
    icon-theme= "Oranchelo";
    show-icons= true;
    drun-display-format= "{icon} {name}";
    location= 0;
    hide-scrollbar= true;
    display-drun= "   Apps ";
    display-run= "   Run ";
    display-window= "   Window";
    display-Network= " 󰤨  Network";
    sidebar-mode= true;
    };
	theme = ./theme.rafi;
  };
}
