
{ pkgs
, host
, options
, ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix) hostId;
in
{
  # Defensive assertion for hostname validity (clearer message at eval time)
  assertions = [
    {
      assertion = builtins.match "^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$" host != null;
      message = "Invalid hostname '${host}'. Must be 1-63 chars, start/end alphanumeric; allowed middle chars: letters, digits, '-' or '_'.";
    }
  ];

  networking = {
    hostName = "${host}";
    hostId = hostId;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
        53317
      ];
      allowedUDPPorts = [
        59010
        59011
        53317
      ];
     #allowedTCPPortRanges = [
      #{ from = 1714; to = 1764; }
      #];
     #allowedUDPPortRanges = [
      #{ from = 1714; to = 1764; }
      #];
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}

