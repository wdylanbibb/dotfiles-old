function expand_mnt
  string replace ~mnt /run/media/$USER $argv
end

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx EDITOR nvim
  abbr -a expant_mnt_dir --position anywhere --regex "~mnt(\\/.*)?" --function expand_mnt
end
