{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix)
    alacrittyEnable
    ghosttyEnable
    tmuxEnable
    waybarChoice
    weztermEnable
    vscodeEnable
    helixEnable
    doomEmacsEnable
    ;
in
{
  imports = [
    ./amfora.nix
    ./bash.nix
    ./bashrc-personal.nix
    ./bat.nix
    ./btop.nix
    ./bottom.nix
    ./cava.nix
    #./dank-material-shell
    ./emoji.nix
    ./eza.nix
    ./fastfetch
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gtk.nix
    ./htop.nix
    ./hyprland
    #./kdeconnect.nix
    ./kitty.nix
    ./lazygit.nix
    #./lazyvim
    #./obs-studio.nix
    ./noctalia-shell
    ./nvf.nix
    #./obs-studio.nix
    #./rmpc.nix
    ./rofi
    ./qt.nix
    ./scripts
    ./scripts/gemini-cli.nix
    #./starship.nix
    #./starship-ddubs-1.nix
    ./stylix.nix
    ./swappy.nix
    ./swaync.nix
    ./tealdeer.nix
    ./vicinae.nix
    ./virtmanager.nix
    #waybarChoice
    ./wlogout
    ./xdg.nix
    ./yazi
    ./zathura.nix
    ./zoxide.nix
    ./zsh
  ]
  ++ (if helixEnable then [ ./evil-helix.nix ] else [ ])
  ++ (if vscodeEnable then [ ./vscode.nix ] else [ ])
  ++ (
    if doomEmacsEnable then
      [
        ./editors/doom-emacs-install.nix
        ./editors/doom-emacs.nix
      ]
    else
      [ ]
  )
  ++ (if weztermEnable then [ ./wezterm.nix ] else [ ])
  ++ (if ghosttyEnable then [ ./ghostty.nix ] else [ ])
  ++ (if tmuxEnable then [ ./tmux.nix ] else [ ])
  ++ (if alacrittyEnable then [ ./alacritty.nix ] else [ ]);
}
