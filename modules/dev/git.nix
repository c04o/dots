{pkgs, ...}: {
  config.flake.modules = {
    # system-wide git requirements
    home-manager.users.coni = {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Connie Caldera";
            email = "166080234+c04o@users.noreply.github.com";
          };
          gpg = {
            format = "openpgp";
            program = "gpg";
          };
        };
        signing = {
          key = "BE9C532A39E47670";
          signByDefault = true;
        };
      };

      home.packages = with pkgs; [
        # simple terminal UI for git commands
        lazygit

        # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
        gnupg
      ];
    };
  };
}
