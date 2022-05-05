# Time Tracker
[Toggl](https://toggl.com/)と[Asana](https://asana.com/ja)を連携させて、タスクの対応状況を管理するためのiOSアプリ

![8co2c-1ea9a](https://user-images.githubusercontent.com/46038618/166850792-35d5eced-4bbb-4667-8ae3-e709d6089aee.gif)

## Usage
タスクの工数に対する意識を高めるために、<br>
現在のタスク名と、その経過時間（現在、当日分、1ヶ月分）を表示して、<br>
現在のタスクの進捗を工数の点から確認できるようにした。<br>
※ タスクのタイムトラッキングには[Toggl](https://toggl.com/)を利用

またよく利用するタスク（MTG, その他, 休憩）をトップ画面に表示、<br>
右にページ遷移すると[Asana](https://asana.com/ja)から取得した直近のタスク一覧が表示されており、<br>
取り組むタスク（Togglに設定されているタスク）の切り替えができる。

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