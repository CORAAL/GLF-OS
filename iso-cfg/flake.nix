{

  description = "GLF-OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # glf.url = "github:Gaming-Linux-FR/GLF-OS/main";
    glf.url = "github:CORAAL/GLF-OS/features_secondaryToolsDisk";
  };

  outputs =
    { nixpkgs, glf, ... }@inputs:
    let
      pkgsSettings =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      specialArgs = { inherit inputs; };
    in
    {
      nixosConfigurations."GLF-OS" = nixpkgs.lib.nixosSystem {
        pkgs = pkgsSettings "x86_64-linux";
        specialArgs = specialArgs;
        modules = [
          ./configuration.nix
          inputs.glf.nixosModules.default
        ];
      };
    };

}
