{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
    ];
  };
}
