# modules/common/base-packages.nix
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    rsync
    nano
  ];
}
