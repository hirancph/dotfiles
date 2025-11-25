{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;

    # We override the package to include plugins for Manga (cb) and PDF (mupdf)
    package = pkgs.zathura.override {
      plugins = [
        pkgs.zathuraPkgs.zathura_pdf_mupdf
        pkgs.zathuraPkgs.zathura_cb # Adds .cbz .cbr support for Manga
      ];
    };

    # Zathurarc configuration
    options = {
      # --- UX Settings ---
      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      font = "JetBrainsMono Nerd Font 12"; # Match your terminal font

      # --- Ricing (Catppuccin Mocha Palette) ---
      # Toggle "Recolor" with Ctrl+R to invert document colors
      recolor = "true";
      recolor-keep-original-hue = "false"; # "true" keeps image colors normal in recolor mode

      };

  };
}
