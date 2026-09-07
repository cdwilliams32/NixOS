# hosts/server/disko-config.nix
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-L" "nixos" "-f" ];
                subvolumes = {
                  "root" = {
                    mountpoint = "/";
                    mountOptions = [ "discard=async" "compress=zstd" "noatime" ];
                  };
                  "home" = {
                    mountpoint = "/home";
                    mountOptions = [ "discard=async" "compress=zstd" "noatime" ];
                  };
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "discard=async" "compress=zstd" "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
