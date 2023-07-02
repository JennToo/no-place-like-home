{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (neovim.override {
        vimAlias = true;
        viAlias = true;
        withPython3 = true;
        configure = {
          customRC = builtins.readFile ../../dotfiles/config/nvim/init.vim;
          packages.nix = with pkgs.vimPlugins; {
            start = [
              nvim-lspconfig
              vim-polyglot
              vim-nix
              nvim-yarp
              ale
              fzf-vim
              indent-blankline-nvim
              rose-pine
              cmp-nvim-lsp
              cmp-buffer
              cmp-path
              cmp-cmdline
              nvim-cmp
              cmp-vsnip
              vim-vsnip
              cmp-tmux
            ];
          };
        };
      })
    ];
}
