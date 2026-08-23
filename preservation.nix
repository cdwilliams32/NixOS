{
  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/var/lib/bluetooth"
        "/etc/ssh"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      # Preserve user files
      users.zia = {
        directories = [
          ".ssh"
      #     ".mozilla"
        ];
      #
      #   files = [
      #
      #   ];
      };
    };
  };
}
