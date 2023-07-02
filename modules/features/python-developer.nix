{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodePackages.pyright
    black
    poetry
    python310Packages.pylama
    python310Packages.pylint
    virtualenv
  ];
}
