
{ ... }: {
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      
      bezier = [
        # Material Design curves
        "md3_standard, 0.2, 0, 0, 1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        
        # Smooth motion curves
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "smoothOut, 0.5, 0, 0.99, 0.99"
        "smoothIn, 0.5, -0.5, 0.68, 1.5"
        
        # Menu animations
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.38, 0.04, 1, 0.07"
        
        # Easing functions
        "easeInOutCirc, 0.85, 0, 0.15, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        
        # Linear for consistent animations
        "linear, 0, 0, 1, 1"
      ];
      
      animation = [
        # Windows - smooth pop-in effect
        "windows, 1, 3, md3_decel, popin 60%"
        "windowsIn, 1, 3, md3_decel, popin 60%"
        "windowsOut, 1, 3, md3_accel, popin 60%"
        "windowsMove, 1, 4, smoothOut, slide"
        
        # Border animations
        "border, 1, 10, default"
        "borderangle, 1, 100, linear, loop"
        
        # Fade effects
        "fade, 1, 3, md3_decel"
        "fadeIn, 1, 3, md3_decel"
        "fadeOut, 1, 3, md3_accel"
        "fadeDim, 1, 4, smoothOut"
        "fadeShadow, 1, 4, smoothOut"
        
        # Layer animations (for bars, notifications, etc.)
        "layersIn, 1, 3, menu_decel, slide"
        "layersOut, 1, 1.6, menu_accel"
        "fadeLayersIn, 1, 2, menu_decel"
        "fadeLayersOut, 1, 4.5, menu_accel"
        
        # VERTICAL workspace switching (your requirement)
        "workspaces, 1, 6, easeOutExpo, slidevert"
        "workspacesIn, 1, 6, easeOutExpo, slidevert"
        "workspacesOut, 1, 6, easeOutExpo, slidevert"
        
        # Special workspace
        "specialWorkspace, 1, 5, md3_decel, slidevert"
      ];
    };
  };
}

