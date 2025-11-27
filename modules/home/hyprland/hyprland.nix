
{ host
, config
, pkgs
, inputs
, ...
}:
let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    extraMonitorSettings
    keyboardLayout
    stylixImage
    ;
in
{
  home.packages = with pkgs; [
    swww
    grim
    slurp
    wl-clipboard
    swappy
    ydotool
    hyprpolkitagent
    hyprland-qtutils # needed for banners and ANR messages
  ];
  
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  
  # Place Files Inside Home Directory
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    ".face.icon".source = ./face.jpg;
    ".config/face.jpg".source = ./face.jpg;
  };
  
  wayland.windowManager.hyprland = {
    
    enable = true;
    package = pkgs.hyprland;
    # plugins = with pkgs; [
    #hyprlandPlugins.hy3
    #];
    
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    
    xwayland = {
      enable = true;
    };
    
    settings = {
      input = {
        kb_layout = "${keyboardLayout}";
        kb_options = [
          "grp:alt_caps_toggle"
          "caps:escape_shifted_capslock"
        ];
        numlock_by_default = true;
        repeat_delay = 300;
        follow_mouse = 1;
        float_switch_override_focus = 0;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          scroll_factor = 0.8;
        };
      };

      gestures = {
        workspace_swipe = 1;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 500;
        workspace_swipe_invert = 1;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = 1;
        workspace_swipe_forever = 1;
      };

      general = {
    "$modifier" = "SUPER";
    layout = "hy3";
    gaps_in = 6;
    gaps_out = 8;
    border_size = 2;
    resize_on_border = true;

    # AESTHETIC CHOICE:
    # Use a gradient for the active border. 
    # This blends the Wallpaper's "Slate" vibe (base0D) with Catppuccin's "Mauve" (base0E).
    "col.active_border" = "rgb(${config.lib.stylix.colors.base0D}) rgb(${config.lib.stylix.colors.base0E}) 45deg";
    
    # Inactive border fades into the background (using base02 - Selection Background)
    "col.inactive_border" = "rgb(${config.lib.stylix.colors.base02})";
};

plugin = {
    hy3 = {
        no_gaps_when_only = 0;
        node_collapse_policy = 2;
        group_inset = 6;
        tab_first_window = false;

        tabs = {
            height = 28;
            padding = 12;
            from_top = false;
            radius = 8;
            border_width = 2;
            render_text = true;
            text_center = true;
            text_font = "JetBrainsMono Nerd Font SemiBold";
            text_height = 13;
            text_padding = 6;

            # -- ACTIVE TAB --
            # Goal: Sleek, "Cyber" look.
            # Instead of a solid block of color, we use the dark selection background (base02)
            # but light it up with the Blue Accent (base0D) for the border and text.
            "col.active" = "rgb(${config.lib.stylix.colors.base02})";
            "col.active.border" = "rgb(${config.lib.stylix.colors.base0D})";
            "col.active.text" = "rgb(${config.lib.stylix.colors.base0D})";

            # -- INACTIVE TAB --
            # Goal: "Glassy" stealth.
            # We use a hardcoded RGBA based on your wallpaper's darkest tone (#141720) 
            # with opacity to let the wallpaper texture show through.
            "col.inactive" = "rgba(20, 23, 32, 0.70)"; 
            "col.inactive.border" = "rgb(${config.lib.stylix.colors.base01})";
            "col.inactive.text" = "rgb(${config.lib.stylix.colors.base04})"; # Muted text

            # -- URGENT TAB --
            # Classic Error Red (base08)
            "col.urgent" = "rgb(${config.lib.stylix.colors.base08})";
            "col.urgent.border" = "rgb(${config.lib.stylix.colors.base08})";
            "col.urgent.text" = "rgb(${config.lib.stylix.colors.base00})"; # Dark text on bright red

            blur = true;
            opacity = 0.85;
        };

    autotile = {
      enable = false;
      ephemeral_groups = true;
      trigger_width = 800;
      trigger_height = 600;
      workspaces = "all";
    };
  };
};
      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = true; # Enabled for better hy3 experience
        swallow_regex = "^(kitty|Alacritty|foot)$";
        vfr = true;
        vrr = 2;

        # Application not responding (ANR) settings
        enable_anr_dialog = true;
        anr_missed_pings = 15;
      };

      # Keep dwindle config for easy fallback
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = true;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      ecosystem = {
        no_donation_nag = true;
        no_update_news = false;
      };

      cursor = {
        sync_gsettings_theme = true;
        no_hardware_cursors = 2;
        enable_hyprcursor = false;
        warp_on_change_workspace = 2;
        no_warps = true;
      };

      render = {
        direct_scanout = 0;
      };

      master = {
        new_status = "master";
        new_on_top = 1;
        mfact = 0.5;
      };

      xwayland = {
        force_zero_scaling = true;
      };
    };

    extraConfig = ''
      plugin=/run/current-system/sw/lib/libhy3.so
      monitor=,preferred,auto,auto
      monitor=Virtual-1,1920x1080@60,auto,1
      ${extraMonitorSettings}
      # To enable blur on waybar uncomment the line below
      #layerrule = blur,waybar
    '';
  };
}

