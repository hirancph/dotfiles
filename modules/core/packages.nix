{
  pkgs,
  inputs,
  zen-browser,
  ...
}:
{
  programs = {
    #kdeconnect.enable = true;
    hyprland = {
      enable = true; # set this so desktop file is created
      withUWSM = false;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true; # Firefox is not installed by default
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    adb.enable = true;
    hyprlock.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Hyprland systeminfo QT  (Optional)
    #inputs.hyprsysteminfo.packages.${pkgs.system}.default
    android-tools
    amfora # Fancy Terminal Browser For Gemini Protocol
    appimage-run # Needed For AppImage Support
    brave # Brave Browser
    brightnessctl # For Screen Brightness Control
    cliphist # Clipboard manager using rofi menu
    cmatrix # Matrix Movie Effect In Terminal
    cowsay # Great Fun Terminal Program
    docker-compose # Allows Controlling Docker From A Single File
    duf # Utility For Viewing Disk Usage In Terminal
    dysk # Disk space util nice formattting
    eza # Beautiful ls Replacement
    ffmpeg # Terminal Video / Audio Editing
    file-roller # Archive Manager
    gcc
    gedit # Simple Graphical Text Editor
    gemini-cli # CLI AI client ONLY (optional)
    gimp # Great Photo Editor
    glxinfo # needed for inxi diag util
    gnumake
    greetd.tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    hyprlandPlugins.hy3
    hyprpicker # Color Picker
    eog # For Image Viewing
    inxi # CLI System Information Tool
    #plasma5Packages.kdeconnect-kde
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    lm_sensors # Used For Getting Hardware Temps
    localsend #connect with phone
    lolcat # Add Colors To Your Terminal Command Output
    lshw # Detailed Hardware Information
    mpv # Incredible Video Player
    ncdu # Disk Usage Analyzer With Ncurses Interface
    nixfmt-rfc-style # Nix Formatter
    nodejs
    nwg-displays # configure monitor configs via GUI
    onefetch # provides zsaneyos build info on current system
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    protonvpn-gui # VPN
    python3 # For python development
    rhythmbox # audio player
    ripgrep # Improved Grep
    #spicetify-cli # Listen to music
    socat # Needed For Screenshots
    telegram-desktop
    typioca # Tui Typing software
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    uwsm # Universal Wayland Session Manager (optional must be enabled)
    v4l-utils # Used For Things Like OBS Virtual Camera
    waypaper # wallpaper changer
    warp-terminal # Terminal with AI support build in
    wf-recorder #screen recorder
    wget # Tool For Fetching Files With Links
    ytmdl # Tool For Downloading Audio From YouTube
    inputs.yt-x.packages."${system}".default
    zen-browser #default browser
  ];
}
