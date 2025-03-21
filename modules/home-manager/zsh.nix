{ config, pkgs, ... }:
let
  shellAliases = {
    update = "sudo nixos-rebuild switch --flake ~/flakenix#default --impure";
    bat = "cat";
    test = "sudo nixos-rebuild test --flake ~/flakenix#default --impure";
    htb = "sudo openvpn ~/ctfs/htb/vpn/lab.ovpn 1>/dev/null &";
    htbr = "sudo openvpn ~/ctfs/htb/vpn/release.ovpn 1>/dev/null &";
    zed = "zeditor";
  };
  shellGlobalAliases = {
    copy = "| wl-copy";
  };
in
{
  programs = {
    thefuck.enable = true;

    zsh = {
      inherit shellAliases shellGlobalAliases;
      enable = true;
      enableCompletion = true;
      autosuggestion = { enable = true; };
      syntaxHighlighting.enable = true;
			historySubstringSearch = {
			enable = true;
			searchDownKey = "$terminfo[kcud1]";
			searchUpKey = "$terminfo[kcuu1]";
			};
      initExtra = ''
        SHELL=${pkgs.zsh}/bin/zsh
        zstyle ':completion:*' menu select
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
      zplug = {
        enable = true;
        plugins = [
          { name = "fdellwing/zsh-bat"; tags = [ "from:oh-my-zsh" ]; }
          { name = "plugins/git"; tags = [ "from:oh-my-zsh" ]; }
        ];
      };
    };
  };
}
