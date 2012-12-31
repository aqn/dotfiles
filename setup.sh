#! /bin/sh
# 初期設定用やっつけスクリプト

getNewName() { 
  echo $1 | sed 's/^_/./'
}

DOTFILESDIR="$HOME/dotfiles"

if [ ! -d $DOTFILESDIR ]; then
  echo "$DOTFILESDIR not found. abort."
  exit 1
fi

pushd $DOTFILESDIR
for f in _*
do
  if [ ! -f $f ]; then
    # ディレクトリは飛ばします
    continue
  fi
  newname=`getNewName $f`
  [ ! -L $HOME/$newname ] &&
    echo ln -s $DOTFILESDIR/$f $HOME/$newname
done

ln -s $DOTFILESDIR/_vim/{after,snippets} \
  $HOME/.vim

popd

echo "done."
