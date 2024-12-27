{
  config,
  lib,
  ...
}: {
  xdg.configFile = {
    "waybar/scripts".source = ./waybar-scripts;
    "waybar/mocha.css".source = ./waybar-scripts/mocha.css;
  };
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false; # Disabling systemd management for Waybar
    };
    settings = [
      {
        # General configuration for Waybar
        layer = "bottom"; # Positioned at the bottom of the screen
        position = "top"; # Waybar position on top of the screen
        spacing = 1;
        exclusive = true;
        gtk-layer-shell = true;
        passthrough = false;
        fixed-center = true;

        # Modules configuration
        modules-left = [
          "hyprland/workspaces"
          "tray"
        ];
        modules-center = [
          "mpris"
        ];
        modules-right = [
          "custom/notification"
          "cpu"
          "custom/gpu"
          "custom/gpu-temp"
          "memory"
          "pulseaudio"
          "clock"
          "clock#simpleclock"
        ];

        # Workspace configuration (using Hyprland)
        "hyprland/workspaces" = {
          persistent-workspaces = {
            "DP-3" = [ 1 ];
          };
        };

        # Tray configuration
        tray = {
          spacing = 10;
        };

        # MPRIS (media player) configuration
        mpris = {
          format = "{player_icon} {status_icon} {dynamic}";
          format-paused = "{player_icon} {status_icon} {dynamic}";
          dynamic-order = [ "title" "artist" "album" ];
          dynamic-len = 90;
          player-icons = {
            default = "";
            firefox = "󰈹";
            vlc = "󰕼";
          };
          status-icons = {
            playing = "";
            paused = "";
          };
        };

        # CPU usage configuration
        cpu = {
          interval = 10;
          format = " {usage}%";
          max-length = 10;
        };

        # GPU usage (using NVIDIA)
        "custom/gpu" = {
          exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          format = "󰊴 {}%";
          return-type = "";
          interval = 5;
        };

        # GPU temperature (using NVIDIA)
        "custom/gpu-temp" = {
          exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
          format = " {}°";
          return-type = "";
          interval = 5;
        };

        # Memory usage configuration
        memory = {
          interval = 30;
          format = " {}%";
          max-length = 10;
        };

        # PulseAudio volume configuration
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " ";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol"; # Opens pavucontrol when clicked
        };

        # Clock with simple format
        "clock#simpleclock" = {
          tooltip = false;
          format = " {:%H:%M}";
        };

        # Main clock with calendar
        clock = {
          format = " {:L%a %d %b}";
          calendar = {
            format = {
              days = "<span weight='normal'>{}</span>";
              months = "<span color='#cdd6f4'><b>{}</b></span>";
              today = "<span color='#f38ba8' weight='700'><u>{}</u></span>";
              weekdays = "<span color='#f5e0dc'><b>{}</b></span>";
              weeks = "<span color='#a6e3a1'><b>W{}</b></span>";
            };
            mode = "month";
            "mode-mon-col" = 1;
            on-scroll = 1;
          };
          tooltip-format = "<span color='#cdd6f4'><tt>{calendar}</tt></span>";
        };

        # Custom notification configuration using swaync-client
        "custom/notification" = {
          escape = true;
          exec = "swaync-client -swb";
          exec-if = "which swaync-client";
          format = "{icon}";
          format-icons = {
            none = "󰅺";
            notification = "󰡟";
          };
          on-click = "sleep 0.1 && swaync-client -t -sw"; # Toggle notifications
          return-type = "json";
          tooltip = false;
        };
      }
    ];

    # Include any additional Waybar style (from local directory)
    style = ./waybar-scripts/style.css;
  };
}
