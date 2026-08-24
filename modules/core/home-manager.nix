{
  inputs,
  pkgs-unstable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs pkgs-unstable;};
    users.hirancph = {
      xdg.configFile."mimeapps.list".force = true;
      imports = [../../home];
      home.username = "hirancph";
      home.homeDirectory = "/home/hirancph/";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };
}
