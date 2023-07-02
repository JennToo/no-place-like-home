{ config, pkgs, lib, ... }: {

  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.writeScript "xrdp-xsession-gnome" ''
      ${pkgs.gnome3.gnome-shell}/bin/gnome-shell &
      waitPID=$!
      ${
        lib.getBin pkgs.dbus
      }/bin/dbus-update-activation-environment --systemd --all
      test -n "$waitPID" && wait "$waitPID"
      /run/current-system/systemd/bin/systemctl --user stop graphical-session.target
      exit 0
    ''}";
    package = pkgs.xrdp.overrideAttrs (oldAttrs: {
      configureFlags = oldAttrs.configureFlags ++ [ "--enable-vsock" ];
      postInstall = oldAttrs.postInstall + ''
        substituteInPlace $out/etc/xrdp/xrdp.ini \
          --replace "use_vsock=false" "use_vsock=true" \
          --replace "security_layer=negotiate" "security_layer=rdp" \
          --replace "crypt_level=high" "crypt_level=none" \
          --replace "bitmap_compression=true" "bitmap_compression=false" \
          --replace "port=3389" "port=vsock://-1:3389"
      '';
    });
  };
  systemd.services.xrdp.serviceConfig.ExecStart = lib.mkForce
    "${config.services.xrdp.package}/bin/xrdp --nodaemon --config ${config.services.xrdp.confDir}/xrdp.ini";

  boot.kernelModules = [ "hv_sock" ];

  environment.etc."X11/Xwrapper.config".text = ''
    allowed_users=anybody
  '';

  environment.etc = {
    "polkit-1/localauthority/50-local.d/45-allow.colord.pkla".source =
      ../../etc/polkit-xrdp/45-allow.colord.pkla;
    "polkit-1/localauthority/50-local.d/46-allow-update-repo.pkla".source =
      ../../etc/polkit-xrdp/46-allow-update-repo.pkla;
    "polkit-1/localauthority/50-local.d/47-allow-networkd.pkla".source =
      ../../etc/polkit-xrdp/47-allow-networkd.pkla;
    "polkit-1/localauthority/50-local.d/48-allow-wi-fi-scans.pkla".source =
      ../../etc/polkit-xrdp/48-allow-wi-fi-scans.pkla;
  };
}
