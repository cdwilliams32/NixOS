# modules/common/auto-upgrade.nix
{ ... }: {
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;   # Allow automatic reboots when needed (kernel updates)
    dates = "02:00";      # Build and activate new generation at 2 AM
    flake = "github:cdwilliams32/NixOS";  # Your config repo
    operation = "boot";   # Add to bootloader, activate on next reboot
    persistent = true;    # Run even if machine was off at scheduled time
  };
}
