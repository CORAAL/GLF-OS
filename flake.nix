{
  description = "GLF-OS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    utils.url   = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... } @ inputs:
    let
      system = "x86_64-linux";

      nixpkgsConfig = {
        allowUnfree = true;
      };

      pkgs = import nixpkgs {
        inherit system;
        config = nixpkgsConfig;
      };

      nixosModules = {
        default = import ./modules/default;
      };

      nixosConfigurations = {
        "glf-installer" = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
            nixosModules.default
            ./iso-cfg/configuration.nix

            {
              nixpkgs.config = nixpkgsConfig;
              nixpkgs.overlays = [
                (self: super: {
                  calamares-nixos-extensions = super.calamares-nixos-extensions.overrideAttrs (oldAttrs: {
                    postInstall = ''
                      cp ${./patches/calamares-nixos-extensions/modules/nixos/main.py}                   $out/lib/calamares/modules/nixos/main.py
                      cp -r ${./patches/calamares-nixos-extensions/config/settings.conf}                 $out/share/calamares/settings.conf
                      cp -r ${./patches/calamares-nixos-extensions/config/modules/packagechooser.conf}   $out/share/calamares/modules/packagechooser.conf
                      cp -r ${./patches/calamares-nixos-extensions/branding/nixos/show.qml}        $out/share/calamares/branding/nixos/show.qml
                      cp -r ${./patches/calamares-nixos-extensions/branding/nixos/white.png}       $out/share/calamares/branding/nixos/white.png
                      cp -r ${./patches/calamares-nixos-extensions/branding/nixos/base.png}        $out/share/calamares/branding/nixos/base.png
                      cp -r ${./patches/calamares-nixos-extensions/branding/nixos/fast.png}        $out/share/calamares/branding/nixos/fast.png
                      cp -r ${./patches/calamares-nixos-extensions/branding/nixos/gaming.png}      $out/share/calamares/branding/nixos/gaming.png
                      cp -r ${./patches/calamares-nixos-extensions/branding/nixos/logo-glf-os.svg} $out/share/calamares/branding/nixos/logo-glf-os.svg
                      cp -r ${./patches/calamares-nixos-extensions/branding/nixos/branding.desc}   $out/share/calamares/branding/nixos/branding.desc
                    '';
                  });
                })
              ];
            }

            ({ config, ... }:
             {
               isoImage = {
                volumeID = nixpkgs.lib.mkDefault "glfos-${config.system.nixos.version}";
                includeSystemBuildDependencies = false;
                storeContents = [ config.system.build.toplevel ];
                squashfsCompression = "zstd -Xcompression-level 22";
                contents = [
                  {
                    source = ./iso-cfg;
                    target = "/iso-cfg";
                  }
                ];
              };
            })
          ];
        };
      };

      # Development shells for multiple systems
      devShells = utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.ruby
              pkgs.bundler
            ];
            shellHook = ''
              cd docs || exit 1
              echo "Running bundle install and starting Jekyll server..."
              bundle install && bundle exec jekyll serve
            '';
          };
        }
      );

    in {
      iso = nixosConfigurations."glf-installer".config.system.build.isoImage;
      inherit nixosConfigurations nixosModules devShells;
    };
}
