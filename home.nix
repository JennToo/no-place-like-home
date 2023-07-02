{ config, pkgs, ... }: {
  home.username = "jwilcox";
  home.homeDirectory = "/home/jwilcox";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.command-not-found.enable = true;
  programs.git = {
    enable = true;
    userName = "Jennifer Wilcox";
    userEmail = "jennifer@nitori.org";
    ignores = [
      "compile_commands.json"
      "/.vscode"
      "/.ezdebugger"
      "/.ccls-cache"
      "/.idea"
      ".bloop"
      ".metals"
      "/*.iml"
      "/project/metals.sbt"
      "/.clangd"
      "/.cache/clangd"
    ];
    difftastic.enable = true;
    extraConfig = {
      init.defaultbranch = "main";
      pull.rebase = "false";
    };
  };
  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./dotfiles/bashrc;
  };

  home.file.".invoke.yaml".text = ''
    run:
      shell: /run/current-system/sw/bin/bash
  '';

  home.file.".ssh/config".source = ./templates/ssh-config;
  home.file.".config/fdignore".source = ./dotfiles/fdignore;
  home.file.".config/alacritty/alacritty.yml".source = ./dotfiles/config/alacritty/alacritty.yml;

  dconf.settings = {
    "org/gnome/desktop/wm/preferences".button-layout =
      "minimize,maximize,close";
    "org/gnome/shell".enabled-extensions =
      [ "appindicatorsupport@rgcjonas.gmail.com" ];
    "org/gnome/shell".disabled-extensions = [ ];
    "org/gnome/shell".favorite-apps = [
      "firefox.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.Console.desktop"
      "discord.desktop"
    ];
    "org/gnome/Console".theme = "day";
  };
}
