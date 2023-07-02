{
  description = "Jennifer's NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    musnix.url = "github:musnix/musnix";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt;

    nixosConfigurations.venezuela = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.musnix.nixosModules.musnix
        inputs.home-manager.nixosModules.home-manager
        {
          networking.hostName = "venezuela";
          boot.kernelPackages =
            inputs.nixpkgs.legacyPackages.x86_64-linux.linuxPackages_6_3;

          fileSystems."/mnt/bigdata-local" = {
            device = "/dev/disk/by-uuid/a4a04330-a8e3-48b8-b706-4a35637c94ac";
            fsType = "ext4";
            options = [ "nofail" ];
          };

          environment.etc = {
            "wireplumber/main.lua.d/51-alsa-disable.lua".text =
              builtins.readFile dotfiles/wireplumber-venezuela-main.lua;
          };
          services.pipewire.wireplumber.enable = true;
        }

        ./modules/hardware-configurations/venezuela.nix
        ./modules/hardware-configurations/efi-boot.nix
        ./modules/features/common.nix
        ./modules/features/gui-common.nix
        ./modules/features/desktop.nix
        ./modules/features/games.nix
        ./modules/features/ssh-server.nix
        ./modules/features/bash-developer.nix
        ./modules/features/python-developer.nix
        ./modules/features/music.nix
        ./modules/features/no-sleep.nix
        ./modules/features/home-samba-mount.nix
        ./modules/programs/renoise.nix
      ];
      specialArgs = { inherit inputs; };
    };

    nixosConfigurations.workvm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        { networking.hostName = "workvm"; }

        ./modules/hardware-configurations/workvm.nix
        ./modules/hardware-configurations/efi-boot.nix
        ./modules/features/common.nix
        ./modules/features/gui-common.nix
        ./modules/features/desktop.nix
        ./modules/features/ssh-server.nix
        ./modules/features/bash-developer.nix
        ./modules/features/python-developer.nix
        ./modules/features/hyperv-enhanced-sessions.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
