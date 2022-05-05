# Time Tracker
[Toggl](https://toggl.com/)と[Asana](https://asana.com/ja)を連携させて、”ポモドーロタイマー”</b>として活用するためのiOSアプリ

![8co2c-1ea9a](https://user-images.githubusercontent.com/46038618/166850792-35d5eced-4bbb-4667-8ae3-e709d6089aee.gif)

## Features
* 現在取り組んでいるタスクの情報を確認できる
    * タスク名
    * 経過時間
    * 本日の合計対応時間
    * 過去1ヶ月の合計対応時間
* よく取り組むタスクを下部にボタン表示されて、タスクの切り替えができる
* 右のページには直近のタスク一覧が表示されており、タスクの切り替えができる

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
1. **Xcodeからアプリをアップロード**
    1. Simulatorに「Any iOS Device」を選択
    2. Product > Archive
    3. Archives画面の「Distribute App」
    4. 「App Store Conect」
    5. 「Upload」
    5. 全てチェック
    6. 適切なProfileを選択
    7. 「Upload」
2. **App Store Connectから配布**
    1. [App Store Connect](https://appstoreconnect.apple.com/apps)を開く
    2. TestFlightタブを選択
    3. 新しくビルドされたアプリを確認
        * グループが適切か確認
        * ステータスに「輸出コンプライアンスがありません。」と表示されている場合には対処<br>
        ※ 基本的に全て「はい」を選択

[iOS アプリ - TestFlight 配布の方法](https://softmoco.com/devenv/ios-test-flight-distribution.php)
### Tips
* アイコンの更新
    1. アイコンの保存<br>
        * 保存先：lib/assets/icon.png
    2. アップデート
        ```bash
        $ flutter pub run flutter_launcher_icons:main
        ```