#!/usr/bin/env bash

abbreviate_path() {
  local pathname="$1";
  pathname=$(sed "s:$HOME::" <<< "$pathname");
  awk -F'/' '{for (i=1; i<=NF; i++) printf substr($i, 1, 1) "/" }' <<< $pathname;
}

git_project_name() {
  local target=$1;
  basename $(git -C $target rev-parse --show-toplevel);
}

git_project_path () {
  local target=$1;
  local rel_path=$(git -C $target rev-parse --show-prefix);
  local parent=$(dirname $rel_path);
  printf "$(abbreviate_path "$parent")$(basename "$rel_path")";
}

in_git_project() {
  git rev-parse --git-dir 2>/dev/null;
}

as_git_project() {
  [ ! in_git_project ] && return 1;

  printf " $(git_project_name $(pane_current_path))";
  return 1;
}

as_path() {
  local target=$(pane_current_path);

  if [[ "$target" = "$HOME" ]]; then
    echo "";
  elif [[ "$target" = "$HOME*" ]]; then
    echo " $(abbreviate_path $(sed "s:$HOME::" <<< "$target"))";
  else
    echo " $(abbreviate_path "$target")";
  fi

  return 0;
}

pane_current_path() {
  tmux display-message -p -F "#{pane_current_path}";
}

smart_window_name() {
  as_git_project || as_path;
}
