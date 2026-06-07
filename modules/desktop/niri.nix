{
  pkgs,
  config,
  inputs,
  theme,
  ...
}: {
  config.flake.modules = {
    nixos.c04o = {
      programs.niri.enable = true;
      services.displayManager.ly.enable = true;
    };

    homeManager.coni = {
      imports = [
        inputs.niri.homeModules.niri
      ];

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
            {command = ["xwayland-satellite"];}
            {command = ["wl-paste" "--type" "text" "--watch" "cliphist" "store"];}
            {command = ["wl-paste" "--type" "image" "--watch" "cliphist" "store"];}
            {command = ["waybar"];}
            {command = ["walker" "--gapplication-service"];}
            {command = ["sunsetr"];}
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
    };
  };
}
