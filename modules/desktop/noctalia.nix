{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      bar.default = {
        capsule = true;
        end = [
          "notifications"
          "clipboard"
          "network"
          "bluetooth"
          "battery"
          "control-center"
          "session"
        ];
        margin_edge = 0;
        margin_ends = 0;
        position = "left";
        radius = 0;
        scale = 1.1000000089406967;
        start = [
          "launcher"
          "media"
          "tray"
          "workspaces"
        ];
        thickness = 37;
      };

      dock = {
        icon_size = 46;
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@eDP-1"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget."lockscreen-login-box@eDP-1" = {
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
      };

      shell = {
        font_family = "JetBrainsMono NF";
        niri_overview_type_to_launch_enabled = true;

        launcher = {
          compact = true;
          session_search = true;
        };
      };

      theme = {
        builtin = "Catppuccin";
        mode = "dark";
        source = "builtin";
      };

      wallpaper = {
        enabled = true;
        default.path = "/path/to/wallpapers/wallpaper.png";
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
        network = {
          show_label = false;
        };
        workspaces = {
          display = "none";
        };
      };
    };
  };
}
