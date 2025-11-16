
{ pkgs, host, ... }:

let
  vars = import ../../hosts/${host}/variables.nix;
  theme = import (../themes + "/${vars.stylixTheme}/default.nix");
in

{
  stylix = {
    enable = true;
    image = vars.stylixImage;  # ADD THIS LINE
    inherit (theme) polarity;
    base16Scheme = theme;
    
    opacity.terminal = 1.0;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };
}
