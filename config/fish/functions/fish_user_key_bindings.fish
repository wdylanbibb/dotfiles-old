function reset-transient --on-event fish_postexec
  set -g TRANSIENT 0
end

function clear_input --on-event fish_preexec
  # Save cursor position, clear line, move down one line, clear line, restore saved cursor position
  # Clears prompt for transient mode
  printf "\e[s\e[2K\e[1B\e[2K\e[u"
end

# Method taken from https://github.com/fish-shell/fish-shell/pull/8142
function maybe_execute
  if commandline --is-valid
    set -g TRANSIENT 1
    commandline -f repaint
  else
    set -g TRANSIENT 0
  end
  commandline -f execute
end

function fish_user_key_bindings
  bind -M insert \r maybe_execute
end
