{ config, pkgs, lib, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia.nix
      #./gaming.nix
      inputs.home-manager.nixosModules.default
      ../../modules/home-manager/stylix.nix
    ];

  fonts = {
    fontDir.enable = true;
		packages = with pkgs; [ 
            nerd-fonts.iosevka
            nerd-fonts._0xproto
            nerd-fonts.jetbrains-mono
    ];
  };

  virtualisation = {
    docker = {
      rootless = {
        enable = true;
      };
      autoPrune = {
        enable = true;
      };
      enable = true; 
      enableOnBoot = true;
    };
    containerd = {
      enable = true;
      settings =
      let
        fullCNIPlugins = pkgs.buildEnv {
          name = "full-cni";
          paths = with pkgs;[
            cni-plugins
            cni-plugin-flannel
          ];
        };
      in
      {
        plugins."io.containerd.grpc.v1.cri".cni = {
          bin_dir = "${fullCNIPlugins}/bin";
          conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
        };
      };
    };
  };

  programs = { 
    firefox.enable = true;
    hyprlock.enable = true;
    virt-manager = {
      enable = false;
 };
    steam = {
      enable = true;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;
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
    qemuGuest = {
    enable = true;
    };
    spice-vdagentd.enable = true;
  };

  time.hardwareClockInLocalTime = true;
  boot = {
    kernelParams = [ "quiet" ];
    kernelModules = [ "zfs" ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    hostId = "ac6db370";
    networkmanager = {
      enable = true;
    };
  };

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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
		useGlobalPkgs = true;
    users = {
      "equinox" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      libnotify
      swww
      waybar
      wlr-randr
      brightnessctl
      papirus-folders
      papirus-icon-theme
      gtk3
      gtk4
      fish
      gtk-engine-murrine
      hyprcursor
      hypridle
      bibata-cursors
      inputs.zen-browser.packages."${system}".default
    ];
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      GSETTINGS_BACKEND = "keyfile";
    };
    etc = {
      "greetd/environments" = {
        text = ''
          Hyprland
        '';
      };
			hosts.mode = "0644";
    };
  };
  systemd.services.containerd.serviceConfig = {
    ExecStartPre = [
      "-${pkgs.zfs}/bin/zfs create -o mountpoint=/var/lib/containerd/io.containerd.snapshotter.v1.zfs zroot/containerd"
    ];
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
	networking.firewall.enable = false;
  stylix.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
