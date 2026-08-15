{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      bar = {
        order = [
          "default"
        ];
        default = {
          background_opacity = 0.0;
          capsule = true;
          end = [
            "clipboard"
            "network"
            "battery"
          ];
          margin_edge = 0;
          margin_ends = 0;
          position = "left";
          radius = 0;
          scale = 1.1000000089406967;
          start = [
            "launcher"
            "workspaces"
          ];
          thickness = 38;
        };
      };

      desktop_widgets = {
        enabled = false;
        /*
        schema_version = 2;
        widget_order = [ ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = false;
        };
        widget = { };
        */
      };

      dock = {
        # couldn't find any 'enabled' variable
        icon_size = 62;
      };

      hot_corners = {
        enabled = true;
        bottom_left = {
          action = "launcher";
        };
      };

      location = {
        auto_locate = true;
      };
      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@winit"
          "lockscreen-login-box@eDP-1"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget = {
          "lockscreen-login-box@eDP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";

            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
          };

          "lockscreen-login-box@winit" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 467.0;
            cy = 951.0;
            output = "winit";
            rotation = 0.0;
            type = "login_box";

            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
          };
        };
      };

      nightlight = {
        enabled = true;
        temperature_day = 2400;
      };

      shell = {
        font_family = "Inter";
        niri_overview_type_to_launch_enabled = true;

        launcher = {
          compact = true;
          session_search = true;
        };

        panel = {
          transparency_mode = "glass";
        };
      };

      theme = {
        builtin = "Catppuccin";
        community_palette = "Oxocarbon";
        mode = "dark";
        source = "builtin";
        wallpaper_scheme = "m3-content";
      };

      wallpaper = {
        enabled = true;
        # just manage wallpapers imperatively
        /*
        default = {
          path = "/home/coni/Pictures/Wallpapers/v1.png";
        };
        last = {
          path = "/home/coni/Pictures/Wallpapers/v1.png";
        };
        monitors = {
          "eDP-1" = {
            path = "/home/coni/Pictures/Wallpapers/v1.png";
          };
        };
        */
      };

      widget = {
        battery = {
          hide_when_full = true;
          hide_when_plugged = true;
          show_label = false;
        };
        clock = {
          format = "{:%H:%M:-:%d:%m}";
        };
        date = {
          vertical_format = "{:%d%m}";
        };
        files = {
          command = "nautilus";
          glyph = "";
          label = "Files";
          type = "custom_button";
        };
        helium = {
          command = "helium";
          glyph = "";
          label = "Helium";
          type = "custom_button";
        };
        media = {
          album_art_only = true;
        };
        network = {
          show_label = false;
        };
        terminal = {
          command = "ghostty";
          glyph = "";
          label = "Terminal";
          type = "custom_button";
        };
        volume = {
          show_label = false;
        };
        weather = {
          show_condition = false;
        };
        workspaces = {
          display = "none";
          # got rid of that disgusting orange
          empty_color = "#6C7086";
          occupied_color = "#6C7086";
        };
      };
    };
  };
}
