{pkgs, ...}: {
  programs = {
    dconf.enable = true;

    localsend.enable = true;

    appimage.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [];
    };
  };
}
