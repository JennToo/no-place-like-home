{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cascadia-code
    inkscape
    keepass
    meld
    noto-fonts-emoji
    obs-studio
    qalculate-gtk
    sitelen-seli-kiwen
    source-code-pro
    wireshark
    xclip
  ];

  services.xserver.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
