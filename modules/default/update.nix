{ lib, config, pkgs, ... }:

{
  options.glf.autoUpgrade = lib.mkOption {
    description = "Enable GLFOS auto-upgrade.";
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.glf.autoUpgrade {

    environment.systemPackages = with pkgs; [ libnotify ];
    
    environment.etc."glfos/update.sh" = {
      text = ''
        #!${pkgs.bash}/bin/bash

        FLAKE_PATH="/etc/nixos"
        FLAKE_NAME="GLF-OS"

        # Check network status
        if ! ${pkgs.iputils}/bin/ping -c 1 google.com &> /dev/null; then
          echo "[ERROR] No internet access" >&2
          exit 1
        fi

        echo "[INFO] Starting flake update for $FLAKE_PATH" >&2
        ${pkgs.nix}/bin/nix flake update --flake $FLAKE_PATH
        if [ $? -ne 0 ]; then
          echo "[ERROR] Flake update failed for $FLAKE_PATH" >&2
          exit 1
        fi

        echo "[INFO] Starting system rebuild with $FLAKE_NAME" >&2
        ${pkgs.nixos-rebuild}/bin/nixos-rebuild boot --flake $FLAKE_PATH#$FLAKE_NAME
        if [ $? -ne 0 ]; then
          echo "[ERROR] System rebuild failed for $FLAKE_NAME" >&2
          exit 1
        fi

        echo "[INFO] GLFOS update and rebuild completed successfully." >&2
      '';
      mode = "0755";
    };

    systemd = {
      services."glfos-update" = {
        description = "Update GLFOS";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        requires = [ "network-online.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = [ "${pkgs.bash}/bin/bash" "/etc/glfos/update.sh" ];
        };
      };
      timers."glfos-update" = {
        description = "Run GLFOS Auto-update script";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "5min";
          Persistent = true;
        };
      };
    };

  };
}
