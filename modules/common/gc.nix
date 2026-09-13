# modules/common/gc.nix
{ ... }: {
  nix.gc = {
    automatic = true;
    dates = "daily";                    # systemd calendar event: daily / weekly / "02:00"
    options = "--delete-older-than 7d";
  };
}
