{
  configs,
  pkgs,
  theme,
  ...
}: {
  programs.btop = {
    enable = true;
    settings = {
      update_ms = 100;
      color_theme = theme.theme.name;
      theme_background = false;
      true_background = false;
      vim_keys = true;
      rounded_corners = true;
      shown_boxes = "cpu mem net proc";
    };
  };

  xdg.configFile."btop/themes/${theme.theme.name}.theme".text = ''
    theme[main_fg]="${theme.colors.fg}"
    theme[title]="${theme.colors.green}"
    theme[hi_fg]="${theme.colors.yellow}"
    theme[selected_bg]="${theme.colors.bg2}"
    theme[selected_fg]="${theme.colors.fg}"
    theme[inactive_fg]="${theme.colors.bg5}"
    theme[graph_text]="${theme.colors.bg5}"
    theme[div_line]="${theme.colors.bg2}"

    theme[cpu_box]="${theme.colors.bg5}"
    theme[mem_box]="${theme.colors.bg5}"
    theme[net_box]="${theme.colors.bg5}"
    theme[proc_box]="${theme.colors.bg5}"

    theme[cpu_start]="${theme.colors.green}"
    theme[cpu_mid]="${theme.colors.yellow}"
    theme[cpu_end]="${theme.colors.red}"

    theme[temp_start]="${theme.colors.green}"
    theme[temp_mid]="${theme.colors.yellow}"
    theme[temp_end]="${theme.colors.red}"

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

    theme[download_start]="${theme.colors.aqua}"
    theme[download_mid]="${theme.colors.blue}"
    theme[download_end]="${theme.colors.purple}"

    theme[upload_start]="${theme.colors.yellow}"
    theme[upload_mid]="${theme.colors.red}"
    theme[upload_end]="${theme.colors.red}"

    theme[process_start]="${theme.colors.green}"
    theme[process_mid]="${theme.colors.yellow}"
    theme[process_end]="${theme.colors.red}"
  '';
}
