# gbc - checkout git branch
gbc() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# gbcm - checkout git branch (including remote branches)
gbcm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# gbd - delete git branch
gbd() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git branch -D $(echo "$branch" | awk '{print $1}')
}

# history 
h() {
  local c
  c=$(history -rn 1 | fzf)
  eval $c
}

# ghq move to repo
gl() {
  local dir
  dir=$(ghq list > /dev/null | fzf-tmux --reverse +m) &&
  cd $(ghq root)/$dir
}

