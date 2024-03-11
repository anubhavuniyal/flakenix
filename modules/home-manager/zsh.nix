{ config, pkgs, ... }:
let
shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/equinox/flakenix#default --impure";
      bat = "cat";
      test = "sudo nixos-rebuild test";
    };
in
{
  programs = {
  thefuck.enable = true;

    zsh = {
      inherit shellAliases;
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        SHELL=${pkgs.zsh}/bin/zsh
        zstyle ':completion:*' menu select
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
      zplug = {
      enable = true;
      plugins = [
        { name = "fdellwing/zsh-bat"; tags = [ from:oh-my-zsh ]; } # Simple plugin installation
        { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
      ];
    };
    };
  };
}

