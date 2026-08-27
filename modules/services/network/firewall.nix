{
  networking.firewall = {
    allowedUDPPorts = [
      53317
      59010
      59011
    ];

    allowedTCPPorts = [
      22
      80
      443
      53317
      59010
      59011
      8080
    ];
  };
}
