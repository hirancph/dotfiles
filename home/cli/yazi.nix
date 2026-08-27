{pkgs, ...}: {
  # terminal file manager
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    # Changing working directory when exiting Yazi
    enableFishIntegration = true;
    shellWrapperName = "yy";
    plugins = {
      inherit (pkgs.yaziPlugins) mount;
      inherit (pkgs.yaziPlugins) wl-clipboard;
    };
  };
}
