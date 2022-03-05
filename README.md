# toggl_pomodoro_app

toggl_pomodoro_appは[Toggl](https://toggl.com/)を<br>
<b>”ポモドーロタイマー”</b>として活用するためのiOSアプリです 

<img src="images/icon.png" width="200"><br>

# Features

# Requirement

# Installation

# Usage

# Get Start
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


# TIPS
* アイコンの更新
    ```bash
    $ flutter pub run flutter_launcher_icons:main
    ```
