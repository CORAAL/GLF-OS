{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options.glf.diskManager.enable = lib.mkOption {
    description = "Enable GLF printing configurations.";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.glf.diskManager.enable (
    {
      environment.systemPackages = with pkgs;[
        inputs.diskManager.packages.x86_64-linux.default
      ];
    }
  );
}
