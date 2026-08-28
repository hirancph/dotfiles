{...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "hirancph";
        email = "hiranchandph@gmail.com";
      };

      # FOSS-friendly settings
      push.default = "simple"; # Match modern push behavior
      credential.helper = "cache --timeout=7200";
      init.defaultBranch = "main"; # Set default new branches to 'main'
      log.decorate = "full"; # Show branch/tag info in git log
      log.date = "iso"; # ISO 8601 date format
      # Conflict resolution style for readable diffs
      merge.conflictStyle = "diff3";
    };
  };
}
