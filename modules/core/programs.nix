{pkgs, ...}: {
  programs = {
    dconf.enable = true;
  };

  appimage.enable = true;

  nix-ld = {
    enable = true;
    libraries = with pkgs; [];
  };
}
