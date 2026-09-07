# modules/server/server-setup.nix
{ ... }: {
  # Server-specific hardening
  security = {
    firewall.enable = true;
    # Allow SSH (or your custom port)
    firewall.allowedTCPPorts = [ 22 ];
    # Allow HTTPS if you plan to host web services
    # firewall.allowedTCPPorts = [ 80 443 ];
  };

  # Optional: automatic updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}
