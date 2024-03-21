{ inputs, lib, config, pkgs, ... }: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.catppuccin.enable = true;
    clipboard.register = "unnamedplus";
    globals.mapleader = " ";
    keymaps = [
      {
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options = {
          desc = "Quit";
        };
      }
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          desc = "Neotree";
        };
      }
    ];
    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      expandtab = true;      # Tabs should be spaces
      shiftwidth = 2;        # Tab width should be 2
      tabstop = 2;           # Tab with should be 2
      cursorline = true;     # Highlight current line
      timeout = true;
      timeoutlen = 500;
    };
    plugins = {
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };
      bufferline = {
        enable = true;
        offsets = [
          {
            filetype = "neo-tree";
            text = "File Explorer";
            highlight = "Directory";
            text_align = "left";
          }
        ];
      };
      treesitter.enable = true;
    };
  };
}
