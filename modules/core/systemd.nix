
# modules/core/system.nix
{ ... }:

{
  # SystemD service optimizations
  systemd.services.NetworkManager-wait-online.enable = false;
  
  # Virtualization settings
  virtualisation.docker.enableOnBoot = false;
  
  # Future system-level optimizations go here
}
