{
  config,
  lib,
  ...
}:
{
  xdg.configFile = {
    "waybar/scripts".source = ./waybar-scripts;
  }; 
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
      };
      settings = [
        {
          layer = "top";
          position = "top";
          height = 40;
          margin = "0 0 0 0";
          modules-left = [
            "custom/powermenu"
            "hyprland/workspaces"
            "tray"
            "bluetooth"
          ];
          modules-center = [
            "clock"
            "idle_inhibitor"
          ];
          modules-right = [
            "backlight"
            "battery"
            "pulseaudio"
            "network"
          ];
          "hyprland/workspaces" = {
            format = "{icon}";
            sort-by-number = true;
            active-only = false;
            format-icons = {
              "1" = " 󰲌 ";
              "2" = "  ";
              "3" = " 󰎞 ";
              "4" = "  ";
              "5" = "  ";
              "6" = " 󰺵 ";
              "7" = "  ";
              urgent = "  ";
              focused = "  ";
              default = "  ";
            };
            on-click = "activate";
          };
          clock = {
            format = "󰃰 {:%a, %d %b, %I:%M %p}";
            interval = 1;
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              "on-click-right" = "mode";
              format = {
                months = "<span color='#cba6f7'><b>{}</b></span>";
                days = "<span color='#b4befe'><b>{}</b></span>";
                weeks = "<span color='#89dceb'><b>W{}</b></span>";
                weekdays = "<span color='#f2cdcd'><b>{}</b></span>";
                today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
              };
            };
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "  ";
              deactivated = "  ";
            };
          };
          backlight = {
            format = " {percent}%";
          };
          bluetooth = {
			  "format-off"= "󰂲";
				"on-click" = "rofi-bluetooth &";
				"format"= "";
	"format-connected"= "";
	"tooltip-format"= "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
	"tooltip-format-connected"= "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
	"tooltip-format-enumerate-connected"= "{device_alias}\t{device_address}";
	"tooltip-format-enumerate-connected-battery"= "{device_alias}\t{device_address}\t{device_battery_percentage}%";
			};
      "custom/powermenu" = {
        "format" = "";
        "on-click" = "zsh -c wlogout";
        "tooltip" = false;
      };
          battery = {
            states = {
              good = 80;
              warning = 50;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-alt = "{time}";
            format-charging = "  {capacity}%";
            format-icons = ["󰁻 " "󰁽 " "󰁿 " "󰂁 " "󰂂 "];
          };
          network = {
            interval = 1;
            format-wifi = "  {essid}";
            format-ethernet = "󰈀 {ipaddr}";
            on-click= "~/.config/waybar/scripts/rofi-network-manager.sh";
            format-disconnected = "󱚵";
            tooltip-format = ''
              {ifname}
              {ipaddr}/{cidr}
              {signalstrength}
              Up: {bandwidthUpBits}
              Down: {bandwidthDownBits}
            '';
          };
          pulseaudio = {
            scroll-step = 2;
            format = "{icon} {volume}%";
            format-bluetooth = " {icon} {volume}%";
            format-muted = "";
            format-icons = {
              headphone = "";
              headset = "";
              default = ["" ""];
            };
          };
          tray = {
            icon-size = 16;
            spacing = 8;
          };
        }
      ];

      style = '' 
          @define-color blue      #89b4fa;
@define-color lavender  #b4befe;
@define-color green     #a6e3a1;
@define-color red       #f38ba8;

* {
  border: 0;
  padding: 0 0;
  font-family: "0xProto Nerd Font";
  font-size: 18px;
  color: white;
}

window#waybar {
  border: 0px solid rgba(0, 0, 0, 0);
  background-color: rgba(0, 0, 0, 0);
}

#workspaces {
  border-radius: 5px;
  margin: 8px;
  background-color: rgb(17, 17, 27);
}

#workspaces button {
  color: rgb(30, 30, 46);
  border-radius: 5px;
  padding-right: 5px;
  margin: 2px 4px;
}

#workspaces button:hover {
background-color: rgb(248, 189, 150);
               color: rgb(26, 24, 38);
}

#workspaces button.active * {
  border-radius: 7px;
               color: rgb(26, 24, 38);
}

#workspaces button.visible {
  background-color: @lavender;
}

#workspaces button.visible * {
  color: rgb(238, 212, 159);
}

#clock,
#battery,
#backlight,
#network,
#pulseaudio,
#mode,
#tray,
#idle_inhibitor,
#custom-powermenu,
#bluetooth {
  border-style: solid;
  background-color: rgb(17, 17, 27);
  margin: 8px 0;
  padding: 5px 0;
}

#custom-powermenu {
               color: rgb(242, 143, 173);
                 padding-left: 20px;
                 padding-right: 20px;
                   border-radius: 10px;
                   margin-left: 10px;
                   margin-right: 5px;
             }

#bluetooth{
				 color: #ABE9B3;
  font-weight: bold;
    padding-left: 20px;
                 padding-right: 20px;
                   border-radius: 10px;
                   margin-right: 10px;
                                      margin-left: 5px;

			 }
			 #bluetooth.disabled{
				color: rgb(255, 255, 255);
        font-weight: bold;
    padding-left: 20px;
                 padding-right: 20px;
                   border-radius: 10px;
                   margin-right: 10px;
                   margin-left: 10px;
			 }

#clock {
  margin-left: 10px;
  border-radius: 10px 0 0 10px;
  padding: 0 20px 0 20px;
  font-weight: bold;
  color: @lavender;
}

#idle_inhibitor.deactivated {
  border-radius: 0 10px 10px 0;
  padding-right: 20px;
  color: rgb(221, 182, 242);
  font-weight: bold
}

#idle_inhibitor.activated {
  border-radius: 0 10px 10px 0;
  padding-right: 20px;
  color: @green;
  font-weight: bold
}

#tray {
  border-radius: 10px;
  padding: 0 10px 0 10px;
  margin-left: 10px;
  font-weight: bold
}

#tray menu {
  background-color: rgb(17, 17, 27);
}

#tray menuitem,
#tray window {
  background-color: transparent;
}

#tray menu menuitem:hover {
  color: #000000;
  background-color: @lavender;
}

#tray > .passive {
  -gtk-icon-effect: dim;
}

#tray > .needs-attention {
  -gtk-icon-effect: highlight;
}

#tray > .active {
}

#backlight {
  color: rgb(248, 189, 150);
  padding: 0 10px 0 20px;
  border-radius: 10px 0 0 10px;
  margin-left: 10px;
  font-weight: bold
}

#battery {
  color: @lavender;
  padding: 0 20px 0 10px;
  border-radius: 0 10px 10px 0;
  margin-right: 10px;
  font-weight: bold
}

#battery.critical:not(.charging) {
  color: @red;
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
  font-weight: bold
}

#battery.charging {
  color: @green;
  font-weight: bold
}

@keyframes blink {
  to {
    color: @red;
  }
}

#network {
  color: #ABE9B3;
  border-radius: 0 10px 10px 0;
  margin-right: 10px;
  padding: 10px;
  font-weight: bold
}

#network.disconnected {
  color: @red;
  margin-right: 10px;
  padding: 10px;
  font-weight: bold
}

#pulseaudio {
  color: rgb(245, 224, 220);
  border-radius: 10px 0 0 10px;
  padding: 10px;
  font-weight: bold
}

#pulseaudio.muted {
  color: @red;
  font-weight: bold
}

tooltip {
  background: rgb(17, 17, 27);
}

tooltip label {
  color: rgb(255, 255, 255);
}
      '';
    };
}
