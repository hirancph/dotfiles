{ pkgs, ... }:
{
  programs.rmpc = {
    enable = true;
    package = pkgs.rmpc; # Defaults to pkgs.rmpc if omitted
    
    # Optional: Declarative configuration (writes to ~/.config/rmpc/config.ron)
    settings = {
      theme = {
        # Example: Matching your Catppuccin preference
        background_color = "default";
        text_color = "#cdd6f4"; 
      };
      # Enable album art if you use Kitty or a compatible terminal
      album_art = {
        method = "kitty"; # or "sixel", "ueberzugpp"
      };
    };
  };
}
