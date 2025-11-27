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
  # ... (Package and file inputs remain the same) ...

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    
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
        kb_options = [ "grp:alt_caps_toggle" "caps:escape_shifted_capslock" ];
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
        
        # Active Border: Solid base04 (Slate Blue) for visibility
        "col.active_border" = "rgb(${config.lib.stylix.colors.base04})";
        
        # Inactive Border: Solid base01 (Lighter Dark) instead of base00
        # Using base01 ensures the border is actually VISIBLE but darker than active.
        # Transparency on borders often looks glitchy or invisible on dark wallpapers.
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base01})";
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

         # Active Tab
         "col.active" = "rgb(${config.lib.stylix.colors.base02})";
         "col.active.border" = "rgb(${config.lib.stylix.colors.base02})";
         "col.active.text" = "rgb(${config.lib.stylix.colors.base07})";

         # Inactive Tab (You liked this part)
         "col.inactive" = "rgba(${config.lib.stylix.colors.base00}b3)"; 
         "col.inactive.border" = "rgb(${config.lib.stylix.colors.base01})";
         "col.inactive.text" = "rgb(${config.lib.stylix.colors.base04})";

         # Urgent Tab
         "col.urgent" = "rgb(${config.lib.stylix.colors.base08})";
         "col.urgent.border" = "rgb(${config.lib.stylix.colors.base08})";
         "col.urgent.text" = "rgb(${config.lib.stylix.colors.base07})";

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

      decoration = {
        rounding = 10;
        
        # --- KEY CHANGE HERE ---
        # This physically darkens the content of inactive windows
        dim_inactive = true;
        dim_strength = 0.4; # 0.0 to 1.0 (0.4 is noticeably dim)
        # -----------------------

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
      
      # ... (Rest of config: misc, cursor, ecosystem, etc. remains same) ...
      
      misc = {
        layers_hog_keyboard_focus = true;
        initial_workspace_tracking = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = true;
        swallow_regex = "^(kitty|Alacritty|foot)$";
        vfr = true;
        vrr = 2;
        enable_anr_dialog = true;
        anr_missed_pings = 15;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
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
      
      ecosystem = {
        no_donation_nag = true;
        no_update_news = false;
      };
    };

    extraConfig = ''
      plugin=/run/current-system/sw/lib/libhy3.so
      monitor=,preferred,auto,auto
      monitor=Virtual-1,1920x1080@60,auto,1
      ${extraMonitorSettings}
    '';
  };
}

