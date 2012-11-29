if [[ ! -o interactive ]]; then
    return
fi

compctl -K _mvnw mvnw

_mvnw() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(mvnw commands)"
  else
    completions="$(mvnw completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
