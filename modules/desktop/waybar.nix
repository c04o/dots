{
  pkgs,
  config,
  inputs,
  theme,
  ...
}: {
  config.flake.modules.homeManager.coni = {
    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 22;
          spacing = 6;

          # module tracking architectures
          modules-left = ["niri/workspaces" "niri/window"];
          modules-center = ["clock"];
          modules-right = ["temperature" "cpu" "memory" "network" "pulseaudio" "bluetooth" "niri/language" "battery"];

          # modules definitions
          "niri/workspaces" = {
            format = "{icon}";
            persistent-workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
            };
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              active = "";
              default = "";
            };
          };

          "niri/window" = {
            format = "{}";
            max-length = 25;
          };

          clock = {
            format = "{:%a %b %d %H:%M}";
            tooltip-format = "<tt>{calendar}</tt>";
          };

          temperature = {
            hwmon-path = ["/sys/class/hwmon/hwmon3/temp1_input"];
            critical-threshold = 80;
            warning-threshold = 50;
            format = "{icon} {temperatureC}°C";
            format-icons = ["" "" "" "" ""];
            tooltip = false;
          };

          cpu = {
            interval = 10;
            format = " {usage}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };

          memory = {
            interval = 10;
            format = " {used:0.1f}/{total:0.1f}G";
            states = {
              warning = 70;
              critical = 90;
            };
          };

          network = {
            format-wifi = "{icon}";
            format-ethernet = " ";
            format-disconnected = "󰤮";
            interval = 2;
            format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰖁";
            format-icons.default = ["󰕿" "󰖀" "󰕾"];
            on-click = "pavucontrol";
          };

          bluetooth = {
            format = "󰂯";
            format-disabled = "󰂲";
            format-connected = "󰂱";
            format-connected-battery = "󰂱 {device_battery_percentage}%";
            tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          };

          "niri/language" = {
            format = "󰌌 {short}";
            tooltip-format = "{long}";
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-time = "{H}h {M}m";
            format-charging = "{icon} {capacity}%";
            format-icons = {
              default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
              charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            };
          };
        };
      };

      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: ${theme.fonts.sans}, ${theme.fonts.propo};
          font-size: 16px;
          min-height: 0;
        }

        #waybar {
          background-color: ${theme.colors.bg_dim};
          color: ${theme.colors.fg};
        }

        #workspaces, #window, #clock, #temperature, #cpu, #memory, #network, #pulseaudio, #bluetooth, #language, #battery {
          padding: 0 8px;
          margin: 4px 2px;
        }

        #workspaces {
          margin: 4px 2px;
          padding: 0 12px;
        }

        #workspaces button {
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

        #workspaces button:hover {
          background: transparent;
          box-shadow: none;
        }

        #workspaces button.active {
          color: ${theme.colors.aqua};
          font-weight: bold;
        }

        #temperature, #cpu, #memory, #battery, #battery.charging {
          color: ${theme.colors.green};
        }

        #temperature.warning, #cpu.warning, #memory.warning, #battery.warning {
          color: ${theme.colors.yellow};
        }

        #temperature.critical, #cpu.critical, #memory.critical, #battery.critical {
          color: ${theme.colors.red};
        }

        #pulseaudio.muted, #bluetooth.disabled, #bluetooth.off {
          color: ${theme.colors.bg5};
        }
      '';
    };
  };
}
