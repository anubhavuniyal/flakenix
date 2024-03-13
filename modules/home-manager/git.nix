{ pkgs, ... }:
let
  email = "anubhavuniyal0917@protonmail.com";
  name = "Anubhav Uniyal";
in
{
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = name;
      push.autoSetupRemote = true;
    };
    userEmail = email;
    userName = name;
  };
}
