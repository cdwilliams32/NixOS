# modules/common/users.nix
{ config, ... }: {
  # Decrypt these to /run/secrets-for-users/ BEFORE users are created
  sops.secrets.user-password-hash.neededForUsers = true;
  sops.secrets.root-password-hash.neededForUsers = true;

  users.users.cdwill = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # hashedPasswordFile = the decrypted secret path (applies on EVERY activation)
    hashedPasswordFile = config.sops.secrets.user-password-hash.path;
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINXwzBlR/2qEohch3WjMe68WZkpl8N3zKtGLbDA408Vt cdwill@USS-Talon" ];
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.root-password-hash.path;
}
