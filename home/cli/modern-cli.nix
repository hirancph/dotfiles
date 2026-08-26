{pkgs, ...}: {
  programs.fish = {
    enable = true;

    shellAliases = {
      cat = "bat";
      ls = "eza";
      la = "eza -lah";
      ll = "eza -lh --no-user --long";
      lt = "eza --tree --level=2";
      tree = "eza --tree";
    };
  };
  home.packages = with pkgs; [
    eza
    bat
    fd
    ripgrep
  ];
}
