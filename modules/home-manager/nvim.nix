{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    globals.mapleader = " ";
    options = {
      linebreak = true;
      clipboard = "unnamedplus";
      cursorline = true;
      number = true;
      relativenumber = true;
      signcolumn = "number";
      tabstop = 2;
      shiftwidth = 2;
      updatetime = 300;
      termguicolors = true;
      mouse = "a";
    };
    plugins = {
      /* Rust */
      rustaceanvim.enable = true;
      /* Telescope */
      telescope.enable = true;
      /* UI */
      oil.enable = true;
      lualine.enable = true;
      notify = {
        enable = true;
        backgroundColour = "#000000";
      };
      noice.enable = true;
      /* CMP/snippets */
      cmp_luasnip.enable = true;
      friendly-snippets.enable = true;
      luasnip = {
        enable = true;
        fromVscode = [{ }];
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
      /* LSP */
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          clangd.enable = true;
          # Rust-analyzer automatically enabled by rustaceanvim
        };
      };
      /* Makes code look nicer */
      illuminate.enable = true;
      treesitter.enable = true;
      /* QOL */
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      comment-nvim.enable = true;
      /* Color preview */
      nvim-colorizer.enable = true;
      /* Dependencies */
      dap.enable = true;
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        options.silent = true;
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        options.silent = true;
        action = "<cmd>Telescope git_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>pv";
        action = "<cmd>Oil<CR>";
      }
      {
        mode = "n";
        key = "<C-d>";
        options.silent = false;
        options.noremap = true;
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        options.silent = false;
        options.noremap = true;
        action = "<C-u>zz";
      }
      {
        mode = "n";
        key = "n";
        options.silent = false;
        options.noremap = true;
        action = "nzz";
      }
      {
        mode = "n";
        key = "N";
        options.silent = false;
        options.noremap = true;
        action = "N/*  */zz";
      }
      {
        mode = "n";
        key = "<Down>";
        options.silent = false;
        options.noremap = true;
        action = "gj";
      }
      {
        mode = "n";
        key = "<Up>";
        options.silent = false;
        options.noremap = true;
        action = "gk";
      }
      {
        mode = [ "i" "s" ];
        key = "<CR>";
        action = "cmp.mapping.confirm({ select = true })";
      }
      {
        key = "<Tab>";
        action = /* lua */ ''
          						function(fallback)
          							if cmp.visible() then
          								cmp.select_next_item()
          							elseif require('luasnip').expandable() then
          								require('luasnip').expand()
          							elseif require('luasnip').expand_or_jumpable() then
          								require('luasnip').expand_or_jump()
          							else
          								fallback()
          							end
          						end
          					'';
      }
    ];
  };
}
