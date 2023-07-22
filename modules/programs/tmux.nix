{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    escapeTime = 1;
    keyMode = "vi";
    historyLimit = 50000;
    extraConfig = builtins.readFile ../../dotfiles/tmux.conf;
  };
}
