{ lib, config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      enable = true;
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "--interactive" ];
      };
      font = {
        normal = {
          family = "0xProto Nerd Font";
          style = "Regular";
        };
        size = 20;
      };
      colors = {
        primary = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
          dim_foreground = "#CDD6F4";
          bright_foreground = "#CDD6F4";
        };
        cursor = {
          text = "#1E1E2E";
          cursor = "#F5E0DC";
        };
        vi_mode_cursor = {
          text = "#1E1E2E";
          cursor = "#B4BEFE";
        };
        search = {
          matches = {
            foreground = "#1E1E2E";
            background = "#A6ADC8";
          };
          focused_match = {
            foreground = "#1E1E2E";
            background = "#A6E3A1";
          };
        };
        footer_bar = {
          foreground = "#1E1E2E";
          background = "#A6ADC8";
        };
        hints = {
          start = {
            foreground = "#1E1E2E";
            background = "#F9E2AF";
          };
          end = {
            foreground = "#1E1E2E";
            background = "#A6ADC8";
          };
        };
        selection = {
          text = "#1E1E2E";
          background = "#F5E0DC";
        };
        normal = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };
        bright = {
          black = "#585B70";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#A6ADC8";
        };
        dim = {
          black = "#45475A";
          red = "#F38BA8";
          green = "#A6E3A1";
          yellow = "#F9E2AF";
          blue = "#89B4FA";
          magenta = "#F5C2E7";
          cyan = "#94E2D5";
          white = "#BAC2DE";
        };
      };
    };
  };
}
