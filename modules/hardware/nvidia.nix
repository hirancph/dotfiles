{
  pkgs,
  config,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = false;
    };

    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Configuration for hybrid AMD+Nvidia laptop
    #prime = {
    #  offload = {
    #    enable = true;
    #    enableOffloadCmd =
    #      true;
    #  };
    #  # sync.enable disabled as offload is generally better for laptops
    #  sync.enable = false;
    #  # PCI IDs verified for your hardware : change?
    #  amdgpuBusId = "PCI:5:0:0"; # Integrated AMD GPU
    #  nvidiaBusId = "PCI:1:0:0"; # Dedicated Nvidia GPU
    #};
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
}
