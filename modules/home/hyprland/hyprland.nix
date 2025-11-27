
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
        layout = "hy3"; # Changed from dwindle to hy3
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        resize_on_border = true;
        # Dark blue solid color (base0E)
        "col.active_border" = "rgb(${config.lib.stylix.colors.base04})";
        "col.inactive_border" = "rgba(${config.lib.stylix.colors.base00}66)";
      };

      # hy3 Plugin Configuration
      plugin = {
        hy3 = {
         no_gaps_when_only = 0; # Hide gaps for a single window for sleekness
         node_collapse_policy = 2;
         group_inset = 6;  # Reduced inset for tighter group appearance
         tab_first_window = false;

        tabs = {
         height = 28;               # Increased tab height for bolder look
         padding = 12;              # More padding to space out tab text and icons
         from_top = false;
         radius = 8;                # Slightly stronger rounding for ends
         border_width = 2;
         render_text = true;
         text_center = true;
         text_font = "JetBrainsMono Nerd Font SemiBold";  # Use a stylish, coding-focused font
         text_height = 13;          # Slightly larger text for clarity
         text_padding = 6;          # Comfortably space text from edges

      # Active tab colors (bold, vivid, stylish)
      "col.active" = "rgb(${config.lib.stylix.colors.base02})";
      "col.active.border" = "rgb(${config.lib.stylix.colors.base02})";
      "col.active.text" = "rgb(${config.lib.stylix.colors.base07})";

      # Inactive tabs: Significantly dimmed
      # Background: base00 (darkest) with low opacity
      "col.inactive" = "rgba(${config.lib.stylix.colors.base00}b3)"; 
         
      # Border: base01 (slightly lighter) but fully opaque for definition
      "col.inactive.border" = "rgb(${config.lib.stylix.colors.base01})";
             
      # Text: base04 (muted grey-blue) instead of base05 (bright text)
      # This makes the text look "dimmed" or "disabled"
      "col.inactive.text" = "rgb(${config.lib.stylix.colors.base04})";

      # Urgent tab colors (high contrast, sharp)
      "col.urgent" = "rgb(${config.lib.stylix.colors.base08})";
      "col.urgent.border" = "rgb(${config.lib.stylix.colors.base08})";
      "col.urgent.text" = "rgb(${config.lib.stylix.colors.base07})";

      blur = true;
      opacity = 0.85;      # Slight transparency for glass effect
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

