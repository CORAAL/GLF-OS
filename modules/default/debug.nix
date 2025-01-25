{ lib, config, pkgs, ... }:

{

  options.glf.debug.enable = lib.mkOption {
    description = "Enable GLF debug";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.glf.debug.enable {

    # Add here your debug configuration
    
  };

}
