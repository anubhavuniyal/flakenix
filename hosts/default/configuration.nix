{ config, pkgs, lib, inputs, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
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
    nh = {
        enable = true;
        flake = "/home/equinox/flakenix";
        clean = {
          enable = true;
          extraArgs = "--keep-since 3d --keep 3";
        };
      };
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
    uwsm.enable = true;
    uwsm.waylandCompositors = {
        hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor manager by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
        };
    };
  };
  # Enable XDG
  xdg.portal.enable = true;

  services = {
    btrfs.autoScrub = {
        enable = true;
        interval = "monthly";
        fileSystems = ["/"];
      };
    pulseaudio = {
          enable = false;
        };
    blueman = {
      enable = true;
    };
    greetd = {
      enable = false;
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
    xserver.enable = true;
    displayManager.defaultSession = "hyprland-uwsm";
    displayManager.sddm = {
        enable = true; # Enable SDDM.
        package = pkgs.kdePackages.sddm;
        extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        sddm-astronaut
        ];
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        settings = {
        Theme = {
            CursorTheme = "Bibata-Modern-Ice";
        };
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
    upower.enable = true;
  };

  time.hardwareClockInLocalTime = true;

  boot = {
    plymouth.enable = true;
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
      sddm-astronaut
      inputs.zen-browser.packages."${system}".default
      nix-output-monitor
      nvd
      gcc-unwrapped
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

  powerManagement.enable = true;

	networking.firewall.enable = false;
  stylix.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
