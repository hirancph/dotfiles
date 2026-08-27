{pkgs, ...}: {
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
      plugins = [
        pkgs.networkmanager-openvpn
      ];
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
      ];
      Domains = ["~."];
      DNSSEC = "allow-downgrade";
      # Use DNS-over-TLS for encrypted DNS queries
      DNSOverTLS = "opportunistic";
      FallbackDNS = [
        "8.8.8.8#dns.google"
        "8.8.4.4#dns.google"
      ];
      # Cache DNS responses for faster lookups
      Cache = "yes";
      CacheFromLocalhost = "yes";
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}

