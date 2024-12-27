{ lib, config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      terminal.shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "--interactive" ];
      };
      keyboard.bindings = [
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }
      ];
    };
  };
}
