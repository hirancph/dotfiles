{pkgs, ...}: {
  home.packages = with pkgs; [
    xwayland-satellite
    sway-contrib.grimshot
  ];
  xdg.configFile."niri" = {
    source = ./niri;
    recursive = true;
  };
}
