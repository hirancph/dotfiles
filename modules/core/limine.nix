{pkgs, ...}: {
  boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
      style.wallpapers = [pkgs.nixos-artwork.wallpapers.simple-dark-gray-bootloader.gnomeFilePath];
      maxGenerations = 10;
    };
  };
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
