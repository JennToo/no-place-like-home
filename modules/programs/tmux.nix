{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    escapeTime = 1;
    keyMode = "vi";
    historyLimit = 50000;
    extraConfig = ''
      unbind C-b
      set-option -g prefix M-a
      bind-key M-a send-prefix

      set -g mouse on

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      set -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ",xterm-256color:RGB"

      bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"

      bind-key % split-window -h -c '#{pane_current_path}'
      bind-key '"' split-window -v -c '#{pane_current_path}'

      set -g base-index 1

      set -g pane-active-border-style fg=colour2,bg=colour2

      set -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}#{pane_pid} \"#{=21:pane_title}\" %H:%M %d-%b-%y"
    '';
  };
}
