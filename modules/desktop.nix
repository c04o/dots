{
  pkgs,
  config,
  inputs,
  ...
}: let
  # pull central theme config
  theme = import ../theme/default.nix;
  themeName = "Everforest-Dark-BL";

  # helper for sunsetr configuration generation
  tomlFormat = pkgs.formats.toml {};

  # wallpaper downloader used by wbg
  myWallpaper = pkgs.fetchurl {
    url = theme.wallpaper.url;
    sha256 = theme.wallpaper.sha256;
  };
in {
  config.flake.modules = {
    # system layer (nixos)
    nixos.c04o = {
      programs.niri.enable = true;
      services.displayManager.ly.enable = true;
    };

    # user layer (home manager)
    homeManager.coni = {
      imports = [
        inputs.nvf.homeManagerModules.default
        # imported from flake inputs
        inputs.niri.homeModules.niri
      ];

      home.sessionVariables = {
        GTK_THEME = themeName;
      };

      gtk = {
        enable = true;
        theme = {
          name = themeName;
          package = pkgs.everforest-gtk-theme;
        };
      };

      # desktop packages
      home.packages = [
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
        # Wallpaper application for Wayland compositors
        pkgs.wbg

        # Automatic blue light filter for Hyprland, Niri, and everything Wayland
        pkgs.sunsetr
      ];

      # sunsetr
      xdg.configFile."sunsetr/sunsetr.toml".source = tomlFormat.generate "sunsetr-config" {
        backend = "wayland";
        transition_mode = "finish_by";
        smoothing = true;
        startup_duration = 0.5;
        shutdown_duration = 0.5;
        adaptive_interval = 1;
        night_temp = 3000;
        day_temp = 6500;
        night_gamma = 100;
        day_gamma = 100;
        update_interval = 60;
        sunset = "18:00:00";
        sunrise = "05:00:00";
        transition_duration = 45;
      };

      # Scrollable-tiling Wayland compositor
      programs.niri = {
        enable = true;

        settings = {
          prefer-no-csd = true;
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          environment = {
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
          };

          spawn-at-startup = [
            {command = ["elephant"];}
            {command = ["sunsetr"];}
            {command = ["xwayland-satellite"];}
            {command = ["wl-paste" "--type" "text" "--watch" "cliphist" "store"];}
            {command = ["wl-paste" "--type" "image" "--watch" "cliphist" "store"];}
            {command = ["waybar"];}
            {command = ["walker" "--gapplication-service"];}
            {command = ["${pkgs.wbg}/bin/wbg" "${myWallpaper}"];}
          ];

          input = {
            keyboard.xkb.layout = "us";
            touchpad = {
              tap = true;
              natural-scroll = true;
              dwt = true;
              accel-profile = "flat";
            };
            mouse.accel-profile = "flat";
          };

          outputs."eDP-1" = {
            scale = 1.0;
            mode = {
              width = 1920;
              height = 1080;
            };
            position = {
              x = 0;
              y = 0;
            };
          };

          layout = {
            gaps = 8;
            center-focused-column = "never";
            default-column-width = {proportion = 0.5;};

            preset-column-widths = [
              {proportion = 1.0 / 3.0;}
              {proportion = 0.5;}
              {proportion = 1.0;}
            ];

            border = {
              enable = true;
              width = 2;
              active.color = theme.colors.aqua;
              inactive.color = theme.colors.bg_dim;
            };

            focus-ring.enable = false;

            shadow = {
              enable = true;
              softness = 30;
              spread = 5;
              offset = {
                x = 0;
                y = 0;
              };
              color = "#00000070";
            };
          };

          animations = {
            enable = true;
            slowdown = 0.75;

            workspace-switch = {
              kind = {
                easing = {
                  duration-ms = 150;
                  curve = "ease-out-quad";
                };
              };
            };
            window-close = {
              kind = {
                easing = {
                  duration-ms = 150;
                  curve = "ease-out-quad";
                };
              };
            };
            horizontal-view-movement = {
              kind = {
                spring = {
                  damping-ratio = 1.0;
                  stiffness = 1000;
                  epsilon = 0.0001;
                };
              };
            };
            window-movement = {
              kind = {
                spring = {
                  damping-ratio = 1.0;
                  stiffness = 1000;
                  epsilon = 0.0001;
                };
              };
            };
          };

          window-rules = [
            {
              geometry-corner-radius = {
                top-left = 18.0;
                top-right = 18.0;
                bottom-left = 18.0;
                bottom-right = 18.0;
              };
              clip-to-geometry = true;
            }
            {
              matches = [
                {
                  app-id = "steam";
                  title = "^notificationtoasts_\\d+_desktop$";
                }
              ];
              default-floating-position = {
                x = 10;
                y = 10;
                relative-to = "bottom-right";
              };
            }
            {
              matches = [
                {
                  app-id = "^(firefox|zen.*)$";
                  title = "^Picture-in-Picture$";
                }
              ];
              open-floating = true;
            }
          ];

          binds = with config.lib.niri.actions; {
            "Mod+Return".action = spawn "ghostty";
            "Mod+Space".action = spawn "walker";
            "Mod+B".action = spawn "zen";

            "Mod+Shift+E".action = quit;
            "Mod+Q".action = close-window;
            "Mod+Shift+P".action = power-off-monitors;
            "Mod+Shift+Slash".action = show-hotkey-overlay;

            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
            };
            "XF86AudioMute" = {
              allow-when-locked = true;
              action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
            };
            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action = spawn "brightnessctl" "set" "+10%";
            };
            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action = spawn "brightnessctl" "set" "10%-";
            };

            "Print".action = spawn "niri" "msg" "action" "screenshot";
            "Ctrl+Print".action = spawn "niri" "msg" "action" "screenshot-screen";
            "Alt+Print".action = spawn "niri" "msg" "action" "screenshot-window";

            "Mod+H".action = focus-column-left;
            "Mod+L".action = focus-column-right;
            "Mod+J".action = focus-window-or-workspace-down;
            "Mod+K".action = focus-window-or-workspace-up;
            "Mod+Left".action = focus-column-left;
            "Mod+Right".action = focus-column-right;
            "Mod+Down".action = focus-window-or-workspace-down;
            "Mod+Up".action = focus-window-or-workspace-up;

            "Mod+Shift+H".action = move-column-left;
            "Mod+Shift+L".action = move-column-right;
            "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
            "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
            "Mod+Shift+Left".action = move-column-left;
            "Mod+Shift+Right".action = move-column-right;
            "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
            "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;

            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+5".action = focus-workspace 5;

            "Mod+F".action = maximize-column;
            "Mod+C".action = center-column;
            "Mod+V".action = toggle-window-floating;
            "Mod+W".action = toggle-column-tabbed-display;
            "Mod+R".action = switch-preset-column-width;
            "Mod+Minus".action = set-column-width "-10%";
            "Mod+Equal".action = set-column-width "+10%";
            "Mod+Shift+F".action = fullscreen-window;

            "Mod+Comma".action = consume-window-into-column;
            "Mod+Period".action = expel-window-from-column;
          };
        };
      };

      # Highly customizable Wayland bar for Sway and Wlroots based compositors
      programs.waybar = {
        enable = true;

        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 22;
            spacing = 6;

            # Module tracking architectures
            modules-left = ["niri/workspaces" "niri/window"];
            modules-center = ["clock"];
            modules-right = ["temperature" "cpu" "memory" "network" "pulseaudio" "bluetooth" "niri/language" "battery"];

            # Modules definitions
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

        # Stylized layout driven via your central theme colors
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
  };
}
