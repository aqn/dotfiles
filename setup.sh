#! /usr/bin/env zsh

autoload colors
colors

success() {
  print -P '%F{green}'$1
}

fail() {
  print -P '%F{red}'$1
}

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -rf "$to"
  ln -s "$from" "$to"
}

DOTFILESDIR="$HOME/dotfiles"

if [ ! -d $DOTFILESDIR ]; then
  fail "$DOTFILESDIR not found. abort."
  exit 1
fi

pushd $DOTFILESDIR
for f in _*
do
  if [ ! -f $f ]; then
    continue
  fi
  newname=`echo $f(:s/_/./)`
  link $DOTFILESDIR/$f $HOME/$newname
done

link $DOTFILESDIR/_vim/after $HOME/.vim/after
link $DOTFILESDIR/_vim/snippets $HOME/.vim/snippets

popd

success "install dotfiles successfully done."
