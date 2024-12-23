{ lib, config, pkgs, ... }:

{

  options.glf.aliases.enable = lib.mkOption {
    description = "Enable GLF Aliases configurations";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.glf.aliases.enable {

    environment.shellAliases = {
      glf-update  = "sudo nix flake update --flake /etc/nixos";
      glf-rebuild = "nh os switch /etc/nixos -H GLF-OS";
      glf-build = "nh os build /etc/nixos -H GLF-OS";
      glf-boot = "nh os boot /etc/nixos -H GLF-OS";
    };
    
  };

}
