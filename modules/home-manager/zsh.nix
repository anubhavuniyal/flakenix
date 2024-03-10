{ config, pkgs, ... }:
{
  programs.zsh = {
    initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 
    '';
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/equinox/flakenix#default --impure";
      bat = "cat";
      test = "sudo nixos-rebuild test";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "fdellwing/zsh-bat"; tags = [ from:oh-my-zsh ]; } # Simple plugin installation
        { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };
}

