{pkgs, ...}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  xdg.portal.enable = true;
}
