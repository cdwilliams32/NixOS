# modules/common/git.nix
# modules/common/git.nix
{ config, ... }: {
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "cdwilliams32";
        email = "github.egwx7@simplelogin.com";
      };
      core = {
        sshCommand = "ssh -i /home/zia/.ssh/github_ed25519 -F /dev/null";
      };
    };
  };

  sops.secrets.github_ssh_key = {
    path = "/home/zia/.ssh/github_ed25519";
    owner = "zia";
    mode = "0600";
  };
}
