{ config, lib, pkgs, ... }: {
  systemd.services.create-swapfile = {
    description = "Create BTRFS swapfile";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    path = [ pkgs.btrfs-progs ];
    script = ''
      if [ ! -f /nix/swapfile ]; then
        btrfs filesystem mkswapfile --size 8g --uuid clear /nix/swapfile
      fi
    '';
  };

  # Make sure the swapfile has the right attributes (COW must be disabled for swap)
  systemd.tmpfiles.rules = [
    "f /nix/swapfile 0600 root root - - -"
  ];
}
