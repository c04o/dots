{
  pkgs,
  theme,
  ...
}: {
  programs.waybar = {
    enable = true;

    # let waybar handle its own systemd service
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 22;
        spacing = 6;

        # module layout
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "temperature"
          "cpu"
          "memory"
          "network"
          "pulseaudio"
          "bluetooth"
          "battery"
        ];

        # modules-left
        "niri/workspaces" = {
          format = "{icon}";

          # force workspaces 1-5 to always exist
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };

          format-icons = {
            # inactive workspaces show their number
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";

            # active workspace gets replaced by the circle
            active = "";

            # fallback for workspaces 5>
            default = "";
          };
        };

        "niri/window" = {
          format = "{}";
          max-length = 25;
        };

        # modules-center
        "clock" = {
          format = "{:%a %b %d %H:%M}";
          # format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<tt>{calendar}</tt>";
        };

        # modules-right
        "temperature" = {
          # temperature sensor path for my hardware
          hwmon-path = [
            "/sys/class/hwmon/hwmon3/temp1_input"
          ];

          critical-threshold = 80;
          warning-threshold = 50;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        "cpu" = {
          interval = 10;
          format = " {usage}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "memory" = {
          interval = 10;
          format = " {used:0.1f}/{total:0.1f}G";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "network" = {
          format-wifi = "{icon}";
          format-ethernet = " ";
          format-disconnected = "󰤮";

          # updates every n seconds
          interval = 2;

          format-icons = [
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰖁";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          # click opens audio mixer
          on-click = "pavucontrol";
        };

        "bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "󰂱 {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-time = "{H}h {M}m";
          format-charging = "{icon} {capacity}%";
          format-icons = {
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
          };
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        /* default sans-serif, nerd font propo fallback */
        font-family: ${theme.fonts.sans}, ${theme.fonts.propo};
        font-size: 16px;
        min-height: 0;
      }

      #waybar {
        background-color: ${theme.colors.bg_dim};
        color: ${theme.colors.fg};
      }

      /* spacing for modules */
      #workspaces, #window, #clock, #temperature, #cpu, #memory, #network, #pulseaudio, #battery {
        padding: 0 8px;
        margin: 4px 2px;
      }

      #workspaces {
        margin: 4px 2px;
        padding: 0 12px;
      }

      /* disable default workspaces buttons styles */
      #workspaces button {
        /* inactive workspaces are faded */
        color: ${theme.colors.bg5};
        background-color: transparent;
        background: transparent;
        padding: 0 5px;
        margin: 0;
        border: none;
        border-radius: 0;
        min-width: 15px;
        box-shadow: none;
      }

      /* removes the ugly grey box when you hover over a workspace */
      #workspaces button:hover {
        background: transparent;
        box-shadow: none;
      }

      /* active workspace highlight */
      #workspaces button.active {
        color: ${theme.colors.aqua};
        font-weight: bold;
      }

      /* "safe" states */
      #temperature, #cpu, #memory, #battery, #battery.charging {
        color: ${theme.colors.green};
      }

      /* warning states */
      #temperature.warning, #cpu.warning, #memory.warning, #battery.warning {
        color: ${theme.colors.yellow};
      }

      /* critical states */
      #temperature.critical, #cpu.critical, #memory.critical, #battery.critical {
        color: ${theme.colors.red};
      }
    '';
  };
}
