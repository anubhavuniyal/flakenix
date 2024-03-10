{ pkgs,lib, inputs, ... }:

let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.waybar}/bin/waybar &
      ${pkgs.swww}/bin/swww init &
      nm-applet --indicator &
      blueman-applet & 
      sleep 1
  
      ${pkgs.swww}/bin/swww img ${./wallpaper.jpg} &
      mako
    '';
in
{
  home.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    GBM_BACKEND= "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME= "nvidia";
    LIBVA_DRIVER_NAME= "nvidia"; # hardware acceleration
    __GL_VRR_ALLOWED="1";
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
    enableNvidiaPatches = true;
    settings = {
      monitor="eDP-1,2560x1440@165,0x0,1.5";
      exec-once = ''${startupScript}/bin/start'';
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "rofi -show run";
      bindm = [
	"$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
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
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
    };
  };
}
