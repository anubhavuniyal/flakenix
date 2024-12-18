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
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/mako.nix
  ];
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      packages = pkgs.papirus-icon-theme;
    };
    theme.packages = pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "mocha";
    };
    theme.name = "catppuccin-Dark";
     gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

  };
  home = {
    username = "equinox";
    homeDirectory = "/home/equinox";
    stateVersion = "24.05";
    packages = with pkgs; [
      vulkan-tools 
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
