
{ config, lib, pkgs, inputs, ... }:

with lib;
let
  nixvim' = inputs.nixvim.legacyPackages."${pkgs.stdenv.system}";

  lazyvimConfig = {
    enableMan = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [
      lua-language-server
      stylua
      ripgrep
      pyright
      ruff
    ];

    extraPlugins = [ pkgs.vimPlugins.lazy-nvim ];

    extraConfigLua =
      let
        plugins = with pkgs.vimPlugins; [
          LazyVim
          bufferline-nvim
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          conform-nvim
          dashboard-nvim
          dressing-nvim
          flash-nvim
          friendly-snippets
          gitsigns-nvim
          indent-blankline-nvim
          lualine-nvim
          neo-tree-nvim
          neoconf-nvim
          neodev-nvim
          noice-nvim
          nui-nvim
          nvim-cmp
          nvim-lint
          nvim-lspconfig
          nvim-notify
          nvim-spectre
          nvim-treesitter
          nvim-treesitter-textobjects
          nvim-ts-autotag
          persistence-nvim
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          trouble-nvim
          which-key-nvim
          { name = "catppuccin"; path = catppuccin-nvim; }
          { name = "mini.ai"; path = mini-nvim; }
          { name = "mini.pairs"; path = mini-nvim; }
        ];
        mkEntryFromDrv = drv:
          if lib.isDerivation drv then
            { name = "${lib.getName drv}"; path = drv; }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        require("lazy").setup({
          defaults = { lazy = true },
          dev = {
            path = "${lazyPath}",
            patterns = { "" },
            fallback = true,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },
            { "nvim-treesitter/nvim-treesitter", opts = function(_, opts) opts.ensure_installed = {} end },
          },
        })
      '';
  };
in
{
  home.packages = [ (nixvim'.makeNixvim lazyvimConfig) ];
  
  # Link your existing lua folder
  xdg.configFile."nvim/lua".source = ./lua;
}
