
{ host, ... }:
let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    browser
    terminal
    ;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      # Enable hy3 layout
      general.layout = "hy3";

      # hy3 plugin configuration
      plugin.hy3 = {
        no_gaps_when_only = 0;
        node_collapse_policy = 2;
        
        tabs = {
          height = 28;
          padding = 12;
          render_text = true;
          text_center = true;
          text_height = 13;
        };
        
        autotile = {
          enable = false;
          trigger_width = 800;
          trigger_height = 600;
        };
      };

      bind = [
        # ───────────────────────── Applications ─────────────────────────
        "$modifier, Return, exec, ${terminal}"
        "$modifier SHIFT, Return, exec, rofi-launcher"
        "$modifier, R, exec, rofi-launcher"
        "$modifier, B, exec, ${browser}"
        "$modifier, Y, exec, kitty -e yazi"
        "$modifier, T, exec, thunar"
        "$modifier, M, exec, pavucontrol"

        # ───────────────────────── Dank Material Shell ─────────────────────────
        "$modifier, N, exec, $HOME/.local/bin/dms ipc call notifications toggle"
        "$modifier SHIFT, escape, exec, $HOME/.local/bin/dms ipc call powermenu toggle"
        "$modifier SHIFT, N, exec, $HOME/.local/bin/dms ipc call notepad open"
        "$modifier SHIFT, B, exec, $HOME/.local/bin/dms ipc call bar toggle 1"
        # ───────────────────────── Utilities ─────────────────────────
        "$modifier, F1, exec, list-keybinds"
        "$modifier, S, exec, screenshootin"
        "$modifier SHIFT, S, exec, wf-recorder -f $HOME/Videos/recording_$(date +'%Y-%m-%d_%H-%M-%S').mp4"
        "$modifier SHIFT, N, exec, swaync-client -rs"
        "$modifier, V, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
        "$modifier, D, exec, vicinae vicinae://toggle"

        # ───────────────────────── Window Management ─────────────────────────
        "$modifier, Q, killactive"
        "$modifier, F, fullscreen"
        "$modifier SHIFT, F, togglefloating"
        "$modifier ALT, F, workspaceopt, allfloat"
        "$modifier SHIFT, C, exit"
        "$modifier, P, pseudo"

        # ───────────────────────── hy3: Focus Movement ─────────────────────────
        "$modifier, h, hy3:movefocus, l"
        "$modifier, j, hy3:movefocus, d"
        "$modifier, k, hy3:movefocus, u"
        "$modifier, l, hy3:movefocus, r"
        "$modifier, left, hy3:movefocus, l"
        "$modifier, down, hy3:movefocus, d"
        "$modifier, up, hy3:movefocus, u"
        "$modifier, right, hy3:movefocus, r"

        # ───────────────────────── hy3: Move Windows ─────────────────────────
        "$modifier SHIFT, h, hy3:movewindow, l"
        "$modifier SHIFT, j, hy3:movewindow, d"
        "$modifier SHIFT, k, hy3:movewindow, u"
        "$modifier SHIFT, l, hy3:movewindow, r"
        "$modifier SHIFT, left, hy3:movewindow, l"
        "$modifier SHIFT, down, hy3:movewindow, d"
        "$modifier SHIFT, up, hy3:movewindow, u"
        "$modifier SHIFT, right, hy3:movewindow, r"

        # ───────────────────────── hy3: Swap Windows ─────────────────────────
        "$modifier ALT, h, swapwindow, l"
        "$modifier ALT, j, swapwindow, d"
        "$modifier ALT, k, swapwindow, u"
        "$modifier ALT, l, swapwindow, r"
        "$modifier ALT, left, swapwindow, l"
        "$modifier ALT, down, swapwindow, d"
        "$modifier ALT, up, swapwindow, u"
        "$modifier ALT, right, swapwindow, r"

        # ───────────────────────── hy3: Splits & Groups ─────────────────────────
        "$modifier, W, hy3:makegroup, v, ephemeral"
        "$modifier, A, hy3:makegroup, h, ephemeral"
        "$modifier, Z, hy3:makegroup, tab"
        "$modifier SHIFT, Z, hy3:changegroup, untab"
        "$modifier CONTROL, W, hy3:changegroup, v"
        "$modifier CONTROL, A, hy3:changegroup, h"
        "$modifier CONTROL, Z, hy3:changegroup, toggletab"
        "$modifier CONTROL, O, hy3:changegroup, opposite"

        # ───────────────────────── hy3: Tab Navigation ─────────────────────────
        "$modifier, TAB, hy3:focustab, r, wrap"
        "$modifier SHIFT, TAB, hy3:focustab, l, wrap"
        "$modifier CONTROL, 1, hy3:focustab, index, 1"
        "$modifier CONTROL, 2, hy3:focustab, index, 2"
        "$modifier CONTROL, 3, hy3:focustab, index, 3"
        "$modifier CONTROL, 4, hy3:focustab, index, 4"
        "$modifier CONTROL, 5, hy3:focustab, index, 5"

        # ───────────────────────── hy3: Focus Management ─────────────────────────
        "$modifier, X, hy3:changefocus, raise"
        "$modifier SHIFT, X, hy3:changefocus, lower"
        "$modifier, U, hy3:changefocus, top"
        "$modifier SHIFT, U, hy3:changefocus, bottom"

        # ───────────────────────── hy3: Expand/Shrink (ALPHA) ─────────────────────────
        "$modifier CONTROL, equal, hy3:expand, expand"
        "$modifier CONTROL, minus, hy3:expand, shrink"
        "$modifier CONTROL, 0, hy3:expand, base"

        # ───────────────────────── Workspaces ─────────────────────────
        "$modifier, 1, workspace, 1"
        "$modifier, 2, workspace, 2"
        "$modifier, 3, workspace, 3"
        "$modifier, 4, workspace, 4"
        "$modifier, 5, workspace, 5"
        "$modifier, 6, workspace, 6"
        "$modifier, 7, workspace, 7"
        "$modifier, 8, workspace, 8"
        "$modifier, 9, workspace, 9"
        "$modifier, 0, workspace, 10"
        
        "$modifier CONTROL, right, workspace, e+1"
        "$modifier CONTROL, left, workspace, e-1"
        "$modifier, mouse_down, workspace, e+1"
        "$modifier, mouse_up, workspace, e-1"

        # ───────────────────────── Move to Workspace ─────────────────────────
        "$modifier SHIFT, 1, hy3:movetoworkspace, 1"
        "$modifier SHIFT, 2, hy3:movetoworkspace, 2"
        "$modifier SHIFT, 3, hy3:movetoworkspace, 3"
        "$modifier SHIFT, 4, hy3:movetoworkspace, 4"
        "$modifier SHIFT, 5, hy3:movetoworkspace, 5"
        "$modifier SHIFT, 6, hy3:movetoworkspace, 6"
        "$modifier SHIFT, 7, hy3:movetoworkspace, 7"
        "$modifier SHIFT, 8, hy3:movetoworkspace, 8"
        "$modifier SHIFT, 9, hy3:movetoworkspace, 9"
        "$modifier SHIFT, 0, hy3:movetoworkspace, 10"

        # ───────────────────────── Special Workspace ─────────────────────────
        "$modifier SHIFT, SPACE, movetoworkspace, special"
        "$modifier, SPACE, togglespecialworkspace"
      ];

      bindm = [
        "$modifier, mouse:272, movewindow"
        "$modifier, mouse:273, resizewindow"
      ];

      # Optional: Tab navigation with mouse
      bindn = [
        ", mouse:272, hy3:focustab, mouse"
      ];
    };
  };
}

