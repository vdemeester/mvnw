_mvnw() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(mvnw commands)" -- "$word") )
  else
    local command="${COMP_WORDS[1]}"
    local completions="$(mvnw completions "$command")"
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -F _mvnw mvnw
