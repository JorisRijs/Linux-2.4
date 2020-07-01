essentialapplication:
  pkg.installed:
      - pkgs:
        - vim
        - tmux
        - curl
  cmd.run:
    - name: sudo -i
