{ pkgs, lib, ... }: {
  stylix.targets.limine.enable = false;

  boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
      maxGenerations = 10;

      resolution = "1920x1080";

      style = {
        wallpapers = [ ./../../themes/nix-kanagawa.png ];
        wallpaperStyle = "stretched";
        backdrop = "1f232a";

        interface = {
          branding = "NixOS // Kanagawa";
          brandingColor = "6";
          helpColor = "7";
          helpHidden = true;
        };

        graphicalTerminal = {
          foreground = "dcd7ba";
          background = lib.mkForce null;
          margin = 0; # Removes the border box and screen frame padding completely

          font = {
            scale = "1x1";
            spacing = 1;
          };

          palette = "1f1f28:c34043:76946a:c0a36e:7e9cd8:957fb8:7aa89f:dcd7ba";
          brightPalette = "2a2a37:e82424:98bb6c:e6c384:7fb4ca:938aa9:7aaa9c:c8c093";
        };
      };
    };
    systemd-boot.enable = lib.mkForce false;
    efi.canTouchEfiVariables = true;
  };

  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}

/*
Limine might not be added to boot entries automatically.
run the following command to add it manually:
sudo efibootmgr -c -d /dev/nvme0n1 -p 1 -L "Limine" -l '\EFI\BOOT\BOOTX64.EFI'
-c (--create): Instructs the utility to generate a brand-new UEFI boot entry.

-d /dev/nvme0n1: Specifies the main physical drive containing your boot partition (the drive device itself, excluding partition numbers).

-p 1: Target partition 1 on that drive (/dev/nvme0n1p1), which is your FAT32 EFI System Partition.

-L "Limine": Defines the display label "Limine" as it will appear in your motherboard’s BIOS boot menu.

-l '\EFI\BOOT\BOOTX64.EFI': Sets the path to the executable binary. UEFI firmware standards mandate backslashes (\) relative to the root of the EFI partition rather than standard Linux forward slashes (/).
*/
