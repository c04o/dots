{
  pkgs,
  theme,
  ...
}: {
  programs.btop = {
    enable = true;

    settings = {
      # 1000ms = 1s
      update_ms = 100;

      # use the theme name from theme file
      color_theme = theme.theme.name;

      # false to make the background transparent
      theme_background = false;

      # true to show true clock in background
      true_background = false;

      # vim keys for navigation
      vim_keys = true;

      # rounded corners for the boxes
      rounded_corners = true;

      # which panels to show and in what order
      shown_boxes = "cpu mem net proc";
    };
  };

  # name the file dynamically
  xdg.configFile."btop/themes/${theme.theme.name}.theme".text = ''
    # foreground
    theme[main_fg]="${theme.colors.fg}"

    # header
    theme[title]="${theme.colors.green}"

    # foreground highlight
    theme[hi_fg]="${theme.colors.yellow}"

    # selected background
    theme[selected_bg]="${theme.colors.bg2}"

    # foreground of selected item
    theme[selected_fg]="${theme.colors.fg}"

    # inactive foreground
    theme[inactive_fg]="${theme.colors.bg5}"

    # foreground in graphs/borders
    theme[graph_text]="${theme.colors.bg5}"
    theme[div_line]="${theme.colors.bg2}"

    # outline colors
    theme[cpu_box]="${theme.colors.bg5}"
    theme[mem_box]="${theme.colors.bg5}"
    theme[net_box]="${theme.colors.bg5}"
    theme[proc_box]="${theme.colors.bg5}"

    # cpu graph colors (green -> yellow -> red)
    theme[cpu_start]="${theme.colors.green}"
    theme[cpu_mid]="${theme.colors.yellow}"
    theme[cpu_end]="${theme.colors.red}"

    # temperature graph colors (green -> yellow -> red)
    theme[temp_start]="${theme.colors.green}"
    theme[temp_mid]="${theme.colors.yellow}"
    theme[temp_end]="${theme.colors.red}"

    # memory meters
    theme[free_start]="${theme.colors.green}"
    theme[free_mid]="${theme.colors.green}"
    theme[free_end]="${theme.colors.green}"

    theme[cached_start]="${theme.colors.blue}"
    theme[cached_mid]="${theme.colors.blue}"
    theme[cached_end]="${theme.colors.blue}"

    theme[available_start]="${theme.colors.aqua}"
    theme[available_mid]="${theme.colors.aqua}"
    theme[available_end]="${theme.colors.aqua}"

    theme[used_start]="${theme.colors.red}"
    theme[used_mid]="${theme.colors.red}"
    theme[used_end]="${theme.colors.red}"

    # network graphs
    theme[download_start]="${theme.colors.aqua}"
    theme[download_mid]="${theme.colors.blue}"
    theme[download_end]="${theme.colors.purple}"

    theme[upload_start]="${theme.colors.yellow}"
    theme[upload_mid]="${theme.colors.red}"
    theme[upload_end]="${theme.colors.red}"

    # process gauge
    theme[process_start]="${theme.colors.green}"
    theme[process_mid]="${theme.colors.yellow}"
    theme[process_end]="${theme.colors.red}"
  '';
}
