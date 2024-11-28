{
  config,
  pkgs,
  inputs,
  ...
}: 
{
  imports = [
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/wlogout.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/zellij.nix
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/ctfs.nix
    ../../modules/home-manager/mako.nix
  ];
  home = {
    pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 20;
  };
    username = "equinox";
    homeDirectory = "/home/equinox";
    stateVersion = "24.05";
    packages = with pkgs; [
      vulkan-tools 
      firefox
      (pass.withExtensions (ext: with ext; [pass-import]))
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
      rofi-bluetooth
      zsh-history-substring-search
      obsidian
      dolphin
      youtube-music
      zed-editor
      minikube
      kubectl
      kubernetes-helm
      vscode
      k9s
    ];
    sessionVariables = {
      seclists = "~/wordlists/share/wordlists/seclists";
    };
  };
  programs.home-manager.enable = true;
}
