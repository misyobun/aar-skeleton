## aar-skeleton
Android Archiveをちょっと手軽にGitHub上に配備するスケルトン

## 使い方
Volleyを例に使う

## レポジトリを作成する
- Repository name: Volley-aar


## スケルトンをダウンロードする
```
$ wget http://dalvik.in/clone.sh | bash
$ mv aar-skeleton volleyaar
```
## 対象ライブラリをクローンする
```
$ cd volleyaar
$ git submodule add https://android.googlesource.com/platform/frameworks/volley
```
## build.gradleを適切に編集する
```
android {
    compileSdkVersion 19
    buildToolsVersion '19.0.0'

    sourceSets {
        main {
            manifest.srcFile 'volley/AndroidManifest.xml'
            java.srcDirs = ['volley/src']
            res.srcDirs = ['volley/res']
        }
    }
}


group = 'jp.co.misyobun.lib.volley'
version = '0.0.1'
def artifactId = 'library'
```

## pushする
```
$ git add .
$ git commit -m "init commit"
$ git remote add origin https://github.com/misyobun/volley-aar.git
$ git push origin master
```

## build する
```
$ /build-gh-pages.sh
```
