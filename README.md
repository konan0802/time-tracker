# toggl_pomodoro_app

[Toggl](https://toggl.com/)と[Asana](https://asana.com/ja)を連携させて、”ポモドーロタイマー”</b>として活用するためのiOSアプリ

<img src="images/icon_round.png" width="200"><br>

## Features

## Requirement

## Installation

## Usage

## Get Start
### Test
* シミュレーターでの実行
    ```bash
    $ cd toggl_pomodoro_app
    $ open -a Simulator
    $ flutter run
    ```
* 実機にインストール
    ```bash
    $ flutter clean
    $ flutter build ios

    # デバイス一覧
    $ flutter devices

    # インストール
    $ flutter install -d {デバイス識別子の頭文字}
    ```
    [flutterをiPhone(実機)にインストールする方法](https://zenn.dev/nnabeyang/scraps/62cea9e93a4409)

### Deploy
Reference
* [iOSアプリの配布方法まとめ](https://qiita.com/mokkos/items/85540e95404df4a9c5a4)
* [iOS アプリ - Ad Hoc 配布の方法](https://softmoco.com/devenv/ios-ad-hoc-distribution.php)
* [iOSアプリの開発環境構築・テスト配布方法](https://www.itd-blog.jp/entry/ios-app)
### Tips
* アイコンの更新
    ```bash
    $ flutter pub run flutter_launcher_icons:main
    ```