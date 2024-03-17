{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/wayland.nix
    ../../modules/home-manager/wlogout.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/zellij.nix
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/ctfs.nix
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
