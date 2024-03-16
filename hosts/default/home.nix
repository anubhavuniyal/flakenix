{ config, pkgs, inputs, ... }:

{
  imports = [
    /home/equinox/flakenix/modules/home-manager/alacritty.nix
    /home/equinox/flakenix/modules/home-manager/tmux.nix
    /home/equinox/flakenix/modules/home-manager/zsh.nix
    /home/equinox/flakenix/modules/home-manager/nvim.nix
    /home/equinox/flakenix/modules/home-manager/hyprland.nix
    /home/equinox/flakenix/modules/home-manager/wayland.nix
    /home/equinox/flakenix/modules/home-manager/wlogout.nix
    /home/equinox/flakenix/modules/home-manager/rofi.nix
    /home/equinox/flakenix/modules/home-manager/git.nix
    /home/equinox/flakenix/modules/home-manager/starship.nix
    /home/equinox/flakenix/modules/home-manager/zellij.nix
    /home/equinox/flakenix/modules/home-manager/btop.nix
  ];
  home = {
    username = "equinox";
    homeDirectory = "/home/equinox";
    stateVersion = "23.11";
    packages = with pkgs; [
      firefox
      (pass.withExtensions (ext: with ext; [ pass-import ]))
      pinentry
      gnupg
      alacritty
      alacritty-theme
      wl-clipboard
      cliphist
      wtype
      grim
      slurp
      swappy
    ];
  };
  programs.home-manager.enable = true;
}
