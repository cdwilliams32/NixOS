# modules/common/users.nix
{ ... }: {
  users.users.cdwill = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINXwzBlR/2qEohch3WjMe68WZkpl8N3zKtGLbDA408Vt cdwill@USS-Talon" ];
  };
}
