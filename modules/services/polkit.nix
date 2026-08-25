{pkgs, ...}: {
  security.polkit.enable = true;

  systemd.user.services.mate-polkit = {
    description = "mate-polkit-authentication-agent";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
      Restart = "on-failure";
      Restartsec = 1;
      TimeoutStopSec = 10;
    };
  };
}
