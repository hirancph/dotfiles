{...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };
  systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
}
