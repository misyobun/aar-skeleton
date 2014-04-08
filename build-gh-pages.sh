#!/bin/bash

HOME_DIR=$PWD
DIR=$(basename $PWD)-pages
URL=$(git config --get remote.origin.url)

# ローカルにあるpagesブランチディレクトリを削除
cd ..
rm -rf $DIR

# pagesブランチディレクトリをチェックアウト
git clone $URL $DIR

# pagesブランチ内の歴史を刷新する
cd $DIR
PAGES_DIR=$PWD

git checkout --orphan gh-pages
rm -rf .gitignore
rm -rf .gitmodules
rm -rf *

# aarを作成してpagesブランチディレクトリに配備する
cd $HOME_DIR
./gradlew -Dorg.gradle.project.repoDir="$PAGES_DIR" uploadArchives

# ディレクトリー階層を記述したHTMLを作成
cd $PAGES_DIR
for DIR in $(find ./ \( -name build -o -name .git -o -name .gitignore \) -prune -o -type d); do
  (
    echo "<html><body><h1>Directory listing</h1><hr/><pre>"
    ls -1p "${DIR}" | grep -v "^\./$" | grep -v "index.html" | awk '{ printf "<a href=\"%s\">%s</a>\n",$1,$1 }' 
    echo "</pre></body></html>"
  ) > "${DIR}/index.html"
done

# pagesブランチディレクトリ内をコミットする
git add --all .
git commit -m "Website at $(date)"

# gh-pagesへpushする
git push origin gh-pages

# 用済みのpagesブランチディレクトリを削除する
cd ..
rm -rf $DIR
