
{ inputs, ... }:
{
  imports = [
    ./hardware.nix
    #inputs.dankMaterialShell.nixosModules.greeter
    ./host-packages.nix
  ];

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}

