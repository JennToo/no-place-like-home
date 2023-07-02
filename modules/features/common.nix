{ pkgs, ... }: {
  imports = [ ../programs/tmux.nix ../programs/neovim.nix ];

  environment.systemPackages = with pkgs; [
    curl
    difftastic
    fd
    file
    fzf
    git
    gnumake
    htop
    killall
    libqalculate
    lsb-release
    nixfmt
    p7zip
    pstree
    ripgrep
    tree
    wget
  ];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  users.users.jwilcox = {
    isNormalUser = true;
    description = "Jennifer";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  home-manager.users.jwilcox = import ../../home.nix;

  system.stateVersion = "22.11";

  services.fwupd.enable = true;
}
