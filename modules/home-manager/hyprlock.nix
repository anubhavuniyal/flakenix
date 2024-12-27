{ config
, lib
, pkgs
, ...
}:
{
    programs.hyprlock = {
      enable = true;
      package = pkgs.hyprlock;

      settings = {
        general = {
          disable_loading_bar = false;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
          no_fade_out = false;
          ignore_empty_input = false;
        };

      };
};
}

