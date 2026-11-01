# modules/common/users.nix
{ config, ... }: {
  # Decrypt these to /run/secrets-for-users/ BEFORE users are created
  sops.secrets.personal_user-password-hash.neededForUsers = true;
  sops.secrets.root-password-hash.neededForUsers = true;

  users.users.cdwill = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # hashedPasswordFile = the decrypted secret path (applies on EVERY activation)
    hashedPasswordFile = config.sops.secrets.personal_user-password-hash.path;
  };
  users.users.root.hashedPasswordFile = config.sops.secrets.root-password-hash.path;
}
