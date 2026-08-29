{pkgs, lib, ...}: {
  boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
      maxGenerations = 10;
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
