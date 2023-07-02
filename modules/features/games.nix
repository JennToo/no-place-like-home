{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ minecraft retroarchFull ];
}
