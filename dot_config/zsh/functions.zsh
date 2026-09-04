ws() {
  local version="$(jj --version | awk '{print $2}')"
  if ! autoload -Uz is-at-least || ! is-at-least 0.38 "$version"; then
    echo "⚠️  jj >= 0.38 is required (current: $version)" >&2
    return 1
  fi

  local workspace_dir="$HOME/dev/.workspaces"
  local command="${1:-}"
  [[ $# -gt 0 ]] && shift

  case "$command" in
    new|create)
      local name="${1:?Usage: ws create <name>}"
      local project="$(basename "$(jj workspace root --name default 2>/dev/null || jj root)")" || return 1
      local dir="$workspace_dir/$project/$name"

      [[ -e "$dir" ]] && { echo "❌ Workspace already exists: $project/$name"; return 1; }

      mkdir -p "$workspace_dir/$project"
      jj workspace add "$dir" || return 1
      cd "$dir" || return 1
      ;;

    list|ls)
      local selected dir
      selected="$(jj workspace list -T 'name ++ "\n"' | fzf --height=40% --reverse)" || return
      [[ -n "$selected" ]] || return

      dir="$(jj workspace root --name "$selected")" || return 1
      cd "$dir" || return 1
      ;;

    remove|rm|delete)
      local selected name dir default_dir changes reply choices
      choices="$(jj workspace list -T 'name ++ "\t" ++ root ++ "\n"')" || return 1
      choices="$(printf '%s\n' "$choices" | awk -F '\t' '$1 != "default"')"
      [[ -n "$choices" ]] || {
        echo "❌ No removable workspaces"
        return 1
      }

      selected="$(printf '%s\n' "$choices" | fzf --height=40% --reverse)" || return
      IFS=$'\t' read -r name dir <<< "$selected"

      [[ -z "$name" || -z "$dir" ]] && return 1
      [[ "$dir" == "$workspace_dir/"* ]] || {
        echo "❌ Workspace outside managed directory: $dir"
        return 1
      }
      [[ -d "$dir" ]] || {
        echo "❌ Workspace directory not found: $dir"
        return 1
      }

      default_dir="$(jj -R "$dir" workspace root --name default 2>/dev/null)" || default_dir="$workspace_dir"

      changes="$(jj diff --summary -R "$dir" 2>/dev/null)" || return 1
      if [[ -n "$changes" ]]; then
        echo "⚠️  Uncommitted changes will be lost in $name:"
        echo "$changes"
      fi
      read -q "reply?Delete workspace $name and its files? [y/N] " || { echo; return 1; }
      echo

      # Return to default workspace before deleting current workspace.
      if [[ "$PWD" == "$dir"/* || "$PWD" == "$dir" ]]; then
        cd "$default_dir" 2>/dev/null || cd "$workspace_dir" || return 1
      fi
      jj -R "$dir" workspace forget "$name" || return 1
      rm -rf -- "$dir" || return 1
      echo "✅ Workspace deleted: $name"
      ;;

    *)
      echo "Usage: ws {new|list|remove}"
      return 1
      ;;
  esac
}
