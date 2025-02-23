{ pkgs
, lib
, self
, config
, hostname
, ...
}:
let
  theme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  wallpaper = ./wallpapers/minimalist-2.jpg;
  cursorSize = 24;
in {
    stylix = {
      image = wallpaper;
      autoEnable = true;
      polarity = "dark";

      base16Scheme = theme;

      opacity = {
        applications = 1.0;
        terminal     = 1.0;
        popups       = 1.0;
        desktop      = 1.0;
      };

      cursor = {
        name    = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size    = cursorSize;
      };

      fonts = {
        sizes = {
          applications = 16;
          terminal     = 20;
          popups       = 12;
          desktop      = 16;
        };

        serif = {
          package = pkgs.nerd-fonts.iosevka;
          name    = "Iosevka Nerd Font Mono";
        };

        sansSerif = config.stylix.fonts.serif;

        monospace = {
          inherit (config.stylix.fonts.serif) package;
          name    = "Iosevka Nerd Font Mono";
        };

        emoji = config.stylix.fonts.serif;

      };
    };
}
