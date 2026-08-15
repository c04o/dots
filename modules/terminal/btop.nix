{...}: {
  programs.btop = {
    enable = true;
    settings = {
      update_ms = 100;
      theme_background = false;
      true_background = false;
      vim_keys = true;
      rounded_corners = true;
      shown_boxes = "cpu mem net proc";
    };
  };
}
