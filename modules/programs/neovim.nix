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
              ale
              cmp-buffer
              cmp-cmdline
              cmp-nvim-lsp
              cmp-path
              cmp-tmux
              cmp-vsnip
              fzf-vim
              indent-blankline-nvim
              neogit
              nvim-cmp
              nvim-lspconfig
              nvim-yarp
              rose-pine
              vim-nix
              vim-polyglot
              vim-vsnip
            ];
          };
        };
      })
    ];
}
