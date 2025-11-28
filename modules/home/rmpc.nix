{ pkgs, ... }:
{
  programs.rmpc.enable = true;
  
  # Manually write the config file to the correct location
  xdg.configFile."rmpc/config.ron".text = ''
    (
        theme: (
            background_color: "default",
            text_color: "#cdd6f4",
        ),
        album_art: (
            method: "kitty",
            max_size_px: (300, 300),
        ),
    )
  '';
}
