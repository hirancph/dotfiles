
{ pkgs, inputs, ... }:
{
  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "hyprland";
    #customConfig = ''
      # Optional custom compositor configuration
    #'';

    configHome = "/home/fattymanul";
    configFiles = [
      "/home/fattymanul/.config/DankMaterialShell/settings.json"
    ];

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };

    # Correct way using your flake input:
    quickshell.package = inputs.quickshell.packages.${pkgs.system}.default;
    # Do not use:
    # quickshell.package = pkgs.quickshell;
  };
}

