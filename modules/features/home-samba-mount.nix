{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/bigdata-remote" = {
    device = "//argentina3.home.nitori.org/bigdata";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "nofail"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "credentials=/etc/nixos/smb-secrets"
      "uid=1000"
      "gid=100"
    ];
  };
}
