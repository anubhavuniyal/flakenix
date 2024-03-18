{ config, lib, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/scripts".source = ./waybar-scripts;
  };
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
             * {
               font-family: "0xProto Nerd Font";
               font-size: 12pt;
               font-weight: bold;
               border-radius: 8px;
               transition-property: background-color;
               transition-duration: 0.5s;
             }
             @keyframes blink_red {
               to {
                 background-color: rgb(242, 143, 173);
                 color: rgb(26, 24, 38);
               }
             }
             .warning, .critical, .urgent {
               animation-name: blink_red;
               animation-duration: 1s;
               animation-timing-function: linear;
               animation-iteration-count: infinite;
               animation-direction: alternate;
             }
             window#waybar {
               background-color: transparent;
             }
             window > box {
               margin-left: 5px;
               margin-right: 5px;
               margin-top: 5px;
               background-color: #1e1e2a;
               padding: 3px;
               padding-left:8px;
               border: 2px none #33ccff;
             }
       #workspaces {
               padding-left: 0px;
               padding-right: 4px;
             }
       #workspaces button {
               padding-top: 5px;
               padding-bottom: 5px;
               padding-left: 6px;
               padding-right: 6px;
             }
       #workspaces button.active {
               background-color: rgb(181, 232, 224);
               color: rgb(26, 24, 38);
             }
       #workspaces button.urgent {
               color: rgb(26, 24, 38);
             }
       #workspaces button:hover {
               background-color: rgb(248, 189, 150);
               color: rgb(26, 24, 38);
             }
             tooltip {
               background: rgb(48, 45, 65);
             }
             tooltip label {
               color: rgb(217, 224, 238);
             }
       #custom-launcher {
               font-size: 20px;
               padding-left: 8px;
               padding-right: 6px;
               color: #7ebae4;
             }
       #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #bluetooth, #custom-powermenu, #custom-cava-internal {
               padding-left: 10px;
               padding-right: 10px;
             }
             /* #mode { */
             /* 	margin-left: 10px; */
             /* 	background-color: rgb(248, 189, 150); */
             /*     color: rgb(26, 24, 38); */
             /* } */
       #memory {
               color: rgb(181, 232, 224);
             }
       #cpu {
               color: rgb(245, 194, 231);
             }
       #clock {
               color: rgb(217, 224, 238);
             }
      /* #idle_inhibitor {
               color: rgb(221, 182, 242);
             }*/
       #custom-wall {
               color: #33ccff;
          }
       #temperature {
               color: rgb(150, 205, 251);
             }
       #backlight {
               color: rgb(248, 189, 150);
             }
       #pulseaudio {
               color: rgb(245, 224, 220);
             }
       #network {
               color: #ABE9B3;
             }
       #network.disconnected {
               color: rgb(255, 255, 255);
             }
       #custom-powermenu {
               color: rgb(242, 143, 173);
               padding-right: 10px;
             }
       #tray {
               padding-right: 8px;
               padding-left: 10px;
             }
       #mpd.paused {
               color: #414868;
               font-style: italic;
             }
       #mpd.stopped {
               background: transparent;
             }
       #mpd {
               color: #c0caf5;
             }
       #custom-cava-internal{
               font-family: "0xProto Nerd Font" ;
               color: #33ccff;
             }
			 #bluetooth{
				 color: #ABE9B3;
			 }
			 #bluetooth.disabled{
				color: rgb(255, 255, 255);
			 }
    '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
			 "hyprland/workspaces"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "cpu"
				"memory"
        "network"
				"bluetooth"
        "custom/powermenu"
        "tray"
      ];
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        all-outputs = true;
        persistent_workspaces = {
          "1" = "[]";
          "2" = "[]";
          "3" = "[]";
        };
        format-icons = {
          "active" = "  ";
          "default" = "  ";
          "empty" = "  ";
        };
      };
      "custom/launcher" = {
        "format" = " ";
        "tooltip" = false;
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
        };
        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
			"bluetooth" = {
			  "format-off"= "󰂲";
				"on-click" = "rofi-bluetooth &";
				"format"= "";
	"format-connected"= "";
	"tooltip-format"= "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
	"tooltip-format-connected"= "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
	"tooltip-format-enumerate-connected"= "{device_alias}\t{device_address}";
	"tooltip-format-enumerate-connected-battery"= "{device_alias}\t{device_address}\t{device_battery_percentage}%";
			};
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %p  %A %b %d}";
        "tooltip" = true;
        "tooltip-format" = "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰻠 {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = "󰍛 {usage}%";
      };
      "network" = {
        "format-disconnected" = "󰯡 ";
        "format-ethernet" = "󰒢 ";
        "format-linked" = "󰖪 {essid}";
        "format-wifi" = "󰖩";
				"on-click"= "~/.config/waybar/scripts/rofi-network-manager.sh";
        "interval" = 1;
      };
      "custom/powermenu" = {
        "format" = "";
        "on-click" = "zsh -c wlogout";
        "tooltip" = false;
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 5;
      };
    }];
  };
}
