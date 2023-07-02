{ pkgs, ... }: { environment.systemPackages = with pkgs; [ shellcheck ]; }
