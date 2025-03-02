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
    ../../modules/home-manager/wlogout.nix
    ../../modules/home-manager/rofi.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/btop.nix
    ../../modules/home-manager/hyprlock.nix
    ../../modules/home-manager/kubernetes.nix
    ../../modules/home-manager/ctfs.nix
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];
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
      base16-schemes
      zed-editor
      hyprpanel
    ];
    sessionVariables = {
      seclists = "~/wordlists/share/wordlists/seclists";
    };
  };
  stylix = {
    targets = {
      rofi = {
        enable = false;
      };
    };
  };
  programs.home-manager.enable = true;
    xdg.configFile."hyprpanel/config.json" = {
    source = ../../modules/home-manager/hyprpanel.json;  # Path relative to your configuration file
    onChange = "${pkgs.procps}/bin/pkill -u $USER -USR1 hyprpanel || true";  # Reload HyprPanel when config changes
  };
}
