{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (renoise.override {
        releasePath = pkgs.fetchurl {
          urls = [ "http://files.home.nitori.org/rns_342_linux_x86_64.tar.gz" ];
          sha256 =
            "3808aeef912ff026768217ec3420e480f3dc96beb030572f26ecbc7025c58769";
        };
      })
    ];
}
