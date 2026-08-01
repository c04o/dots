{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    /*
    settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      environment = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        DISPLAY = ":0";
      };

      spawn-at-startup = [
        {command = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"];}
        {command = ["xwayland-satellite"];}
        {command = ["wl-paste" "--type" "text" "--watch" "cliphist" "store"];}
        {command = ["wl-paste" "--type" "image" "--watch" "cliphist" "store"];}
        {command = ["noctalia"];}
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
          active.color = "#cba6f7";
          inactive.color = "#585b70";
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
              app-id = "^(firefox|helium.*)$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        {
          matches = [
            {
              app-id = "com.mitchellh.ghostty";
            }
          ];
          background-effect = {
            blur = true;
          };
        }
      ];
      binds = with config.lib.niri.actions; {
        # terminal emulator
        "Mod+Return".action = spawn "ghostty";

        # browser
        "Mod+B".action = spawn "helium";

        # file explorer
        "Mod+F".action = spawn "nautilus";

        # system
        "Mod+Shift+E".action = quit;
        "Mod+Q".action = close-window;
        "Mod+Shift+P".action = power-off-monitors;
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        # audio & brightness
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

        # screenshots
        "Print".action = spawn "niri" "msg" "action" "screenshot";
        # interactive area screenshot
        "Ctrl+Print".action = spawn "niri" "msg" "action" "screenshot-screen";
        "Alt+Print".action = spawn "niri" "msg" "action" "screenshot-window";

        # nav: focus
        # vim-motions
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        # arrow keys
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;

        # nav: move windows/columns
        # vim-motions
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
        # arrow keys
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;

        # workspaces: focus jumps
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;

        # layout actions
        "Mod+M".action = maximize-column;
        "Mod+C".action = center-column;
        "Mod+V".action = toggle-window-floating;
        "Mod+W".action = toggle-column-tabbed-display;
        "Mod+R".action = switch-preset-column-width;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+F".action = fullscreen-window;

        # niri groupings
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
      };
    };
    */
    config = ''
        prefer-no-csd
        screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

        environment {
            ELECTRON_OZONE_PLATFORM_HINT "auto"
            DISPLAY ":0"
        }

        spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        spawn-at-startup "xwayland-satellite"
        spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
        spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"
        spawn-at-startup "noctalia"

        input {
            keyboard {
                xkb {
                    layout "us"
                }
            }
            touchpad {
                tap
                natural-scroll
                dwt
                accel-profile "flat"
            }
            mouse {
                accel-profile "flat"
            }
        }

        output "eDP-1" {
            scale 1.0
            mode "1920x1080"
            position x=0 y=0
        }

        layout {
            gaps 4
            center-focused-column "never"

            default-column-width { proportion 0.5; }

            preset-column-widths {
                proportion 0.33333
                proportion 0.5
                proportion 1.0
            }

            border {
                width 1.35
                active-color "#cba6f7"
                inactive-color "#585b70"
            }

            focus-ring {
                off
            }

            shadow {
                on
                softness 30
                spread 5
                offset x=0 y=0
                color "#00000070"
            }
        }

      animations {
            slowdown 0.75

            workspace-switch {
                duration-ms 150
                curve "ease-out-quad"
            }

            window-close {
                duration-ms 150
                curve "ease-out-quad"
            }

            horizontal-view-movement {
                spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
            }

            window-movement {
                spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
            }
        }

        window-rule {
            geometry-corner-radius 8.0 8.0 8.0 8.0
            clip-to-geometry true
        }
        window-rule {
            match app-id="steam" title="^notificationtoasts_\\d+_desktop$"
            default-floating-position x=10 y=10 relative-to="bottom-right"
        }
        window-rule {
            match app-id="^(firefox|helium.*)$" title="^Picture-in-Picture$"
            open-floating true
        }

        window-rule {
            match app-id="com.mitchellh.ghostty"
            draw-border-with-background false
            background-effect {
                blur true
            }
        }

        binds {
            Mod+Return { spawn "ghostty"; }
            Mod+B { spawn "helium"; }
            Mod+F { spawn "nautilus"; }
            Mod+Shift+E { quit; }
            Mod+Q { close-window; }
            Mod+Shift+P { power-off-monitors; }
            Mod+Shift+Slash { show-hotkey-overlay; }

            XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
            XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
            XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
            XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "+10%"; }
            XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "10%-"; }

            Print { spawn "niri" "msg" "action" "screenshot"; }
            Ctrl+Print { spawn "niri" "msg" "action" "screenshot-screen"; }
            Alt+Print { spawn "niri" "msg" "action" "screenshot-window"; }

            Mod+H { focus-column-left; }
            Mod+L { focus-column-right; }
            Mod+J { focus-window-or-workspace-down; }
            Mod+K { focus-window-or-workspace-up; }

            Mod+Left { focus-column-left; }
            Mod+Right { focus-column-right; }
            Mod+Down { focus-window-or-workspace-down; }
            Mod+Up { focus-window-or-workspace-up; }

            Mod+Shift+H { move-column-left; }
            Mod+Shift+L { move-column-right; }
            Mod+Shift+J { move-window-down-or-to-workspace-down; }
            Mod+Shift+K { move-window-up-or-to-workspace-up; }

            Mod+Shift+Left { move-column-left; }
            Mod+Shift+Right { move-column-right; }
            Mod+Shift+Down { move-window-down-or-to-workspace-down; }
            Mod+Shift+Up { move-window-up-or-to-workspace-up; }

            Mod+1 { focus-workspace 1; }
            Mod+2 { focus-workspace 2; }
            Mod+3 { focus-workspace 3; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }

            Mod+M { maximize-column; }
            Mod+C { center-column; }
            Mod+V { toggle-window-floating; }
            Mod+W { toggle-column-tabbed-display; }
            Mod+R { switch-preset-column-width; }
            Mod+Minus { set-column-width "-10%"; }
            Mod+Equal { set-column-width "+10%"; }
            Mod+Shift+F { fullscreen-window; }

            Mod+Comma { consume-window-into-column; }
            Mod+Period { expel-window-from-column; }
        }
    '';
  };

  # resilient systemd service for xwayland-satellite
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Xwayland Satellite";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      # some users need to unset WAYLAND_DISPLAY, others won't
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite :0";
      Restart = "always";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
