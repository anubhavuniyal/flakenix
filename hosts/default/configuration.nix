{ config, pkgs, lib, inputs, ... }:
let
  unstable = import
    (builtins.fetchTarball {
      url = "https://github.com/nixos/nixpkgs/tarball/nixos-unstable";
      sha256 = "0mhh8wyfcncg1sjkpdy72afhi964h5i70vampc60pslaqd1s06pa";
    })
    { inherit (config.nixpkgs) config; };
in
{
  imports =
    [
      ./hardware-configuration.nix
      /home/equinox/flakenix/hosts/default/nvidia.nix
      inputs.home-manager.nixosModules.default
    ];
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [ (unstable.nerdfonts.override { fonts = [ "0xProto" ]; }) ];
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
    light = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };
  # Enable XDG
  xdg.portal.enable = true;

  services = {
    blueman = {
      enable = true;
    };
    greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --asterisks \
            --user-menu \
            --cmd Hyprland
        '';
      };
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };
    printing = {
      enable = true;
    };
    openssh = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  time.hardwareClockInLocalTime = true;
  boot = {
    kernelParams = [ "quiet" ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager = {
      enable = true;
    };
  };

  # Enable zsh system-wide

  # Enable flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    pulseaudio = {
      enable = false;
    };
  };
  users.users.equinox = {
    isNormalUser = true;
    description = "equinox";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "equinox" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      mako
      libnotify
      swww
      waybar
      wlr-randr
      networkmanagerapplet
      brightnessctl
      playerctl
    ];
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    etc = {
      "greetd/environments" = {
        text = ''
          Hyprland
        '';
      };
    };
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
  };
  system.stateVersion = "23.11"; # Did you read the comment?
}