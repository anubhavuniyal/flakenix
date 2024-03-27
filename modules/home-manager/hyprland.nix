{ pkgs, lib, inputs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    sleep 1
  
    ${pkgs.swww}/bin/swww img ${./wallpapers/minimalist-2.jpg} &
    mako &
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store
  '';
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  slurp = "${pkgs.slurp}/bin/slurp";
  grim = "${pkgs.grim}/bin/grim";
  swappy = "${pkgs.swappy}/bin/swappy";
in
{
  home.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
    __GL_VRR_ALLOWED = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      monitor = "eDP-1,2560x1440@165,0x0,1.6";
      exec-once = ''${startupScript}/bin/start'';
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 3;
      };

      decoration = {
        rounding = 5;
      };
      input = {
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
          drag_lock = true;
        };
      };
      misc = {
        disable_splash_rendering = true;
      };
      decoration = {
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "rofi -show run";
      "$clipboard" = "cliphist list | rofi -dmenu -p 'Select item to copy' -lines 10 -width 35 | cliphist decode | wl-copy && wtype -M ctrl v -m ctrl";
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindle = [
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
        ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
        ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
        ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ];
      bindl = [
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];
      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, R, exec, $menu"
        "$mod, M, exit,"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, h"
        "$mod, up, movefocus, k"
        "$mod, down, movefocus, j"
        "$mod, C, killactive,"
        "$mod, V, exec, $clipboard"
        "$mod, F, togglefloating,"
        "$mod, P, exec, ${grim} -g \"$(${slurp})\" - | ${swappy} -f -"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };
}

