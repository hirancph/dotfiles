{pkgs, ...}: {
  users.users.hirancph = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "i2c"
      "wheel"
      "input"
      "video"
      "networkmanager"
    ];
  };
  programs = {
    fish.enable = true;
  };
}
