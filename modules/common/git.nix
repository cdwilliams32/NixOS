# modules/common/git.nix
{ config, ... }: {
  programs.git = {
    enable = true;
    userName = "cdwilliams32";
    userEmail = "github.egwx7@simplelogin.com";
    extraConfig = {
      init.defaultBranch = "main";
      # Make git use the GitHub SSH key for push/pull over SSH
      # (-F /dev/null ignores any ~/.ssh/config so only this key is used)
      "core.sshCommand" = "ssh -i /home/cdwill/.ssh/github_ed25519 -F /dev/null";
    };
  };

  # Place the GitHub SSH private key into the user's home from SOPS
  sops.secrets.github_ssh_key = {
    path = "/home/cdwill/.ssh/github_ed25519";
    owner = "cdwill";
    mode = "0600";
  };
}
