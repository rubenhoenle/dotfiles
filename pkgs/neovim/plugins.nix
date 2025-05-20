{ pkgs, pkgs-unstable, ... }: with pkgs.vimPlugins;
let
  transparent = pkgs.vimUtils.buildVimPlugin {
    name = "vim-better-whitespace";
    src = pkgs.fetchFromGitHub {
      owner = "xiyaowong";
      repo = "transparent.nvim";
      rev = "f09966923f7e329ceda9d90fe0b7e8042b6bdf31";
      sha256 = "sha256-Z4Icv7c/fK55plk0y/lEsoWDhLc8VixjQyyO6WdTOVw=";
    };
  };
  nvim-dev-webicons = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-dev-webicons";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-tree";
      repo = "nvim-dev-webicons";
      rev = "925e2aa30dc9fe9332060199c19f132ec0f3d493";
      sha256 = "+T88roJ4pa7/2p2Bdevn+wTNAXgGmB+QkaLRq2rtUUQ=";
    };
  };
in
[
  nvim-treesitter.withAllGrammars
  nvim-lspconfig

  onedark-nvim
  transparent

  lsp_lines-nvim
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp-treesitter
  luasnip
  cmp_luasnip
  friendly-snippets

  comment-nvim
  vim-surround
  vim-repeat

  telescope-nvim
  telescope-fzf-native-nvim

  nvim-dev-webicons

  undotree
  vim-fugitive
  gitsigns-nvim
  git-blame-nvim
]
