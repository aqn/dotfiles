#! /bin/zsh

DOTFILESDIR="$HOME/dotfiles"

if [ ! -d $DOTFILESDIR ]; then
  echo "$DOTFILESDIR not found. abort."
  exit 1
fi

pushd $DOTFILESDIR
for f in _*
do
  if [ ! -f $f ]; then
    continue
  fi
  newname=`echo $f(:s/_/./)`
  [ ! -L $HOME/$newname ] && ln -s $DOTFILESDIR/$f $HOME/$newname
done

ln -s $DOTFILESDIR/_vim/{after,snippets} $HOME/.vim

popd

echo "done."
