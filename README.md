# GitHub_search_app
> **:warning: みてる人へ**  
> - このコードは指摘されたところを自分なりに頑張って改善したものです。

GithubAPIを利用してGithubのリポジトリを検索する超シンプルなアプリです。ど素人なので可能な限り頑張って、要件を満たすように作りました。


> **:warning: 採点の前に**  
> - 中の人はFlutter歴１年でド素人です。インターンにも落ちまくっておりチーム開発の経験がありません。なのでGithubのリポジトリ運用がめちゃくちゃだったりコード規則ガン無視で最高に汚いです。お許しください。
> - GithubのAPIを認証していないため１分につき10回りクエストで制限がきます。なので全力でスワイプしスクロールし続けると「不正なリクエストが送信されました」と出る場合があります。
> - できないならば出来ないなりに努力してChatGPTやネット等を使い調べて完成させました。拙い部分もありますが採点よろしくお願いします。  
> -  ChatGPTのプロンプトは「お前はイケてるFlutterエンジニアだ。今俺はこういう（Githubの要件を覚えさせる）アプリを作ってるんやけど、助けてほしい。」と入力。

## とりまアプリの全体像

一覧(Light)|一覧(Dark)
--|--
![index-light](https://user-images.githubusercontent.com/39609331/246593499-2ae49fd5-6828-4d26-bf27-ed96247731e1.PNG)|![index-dark](https://user-images.githubusercontent.com/39609331/246593502-acb74ebd-a2d5-4947-bc67-24b8d7ab0ce3.PNG)

詳細|0件|エラー
--|--|--
![view](https://user-images.githubusercontent.com/39609331/246593594-a6320952-c1f6-43e9-8516-82b7d8a0b22d.PNG)|![empty](https://user-images.githubusercontent.com/39609331/246593598-0c3edda5-50db-4ef1-8ba8-c50d6a1f5889.PNG)|![error](https://user-images.githubusercontent.com/39609331/246593596-c1e630bf-6234-4d53-abf4-448bf06e688d.PNG)

![github_search_0_9_0_demo](https://user-images.githubusercontent.com/39609331/246594092-7e26ccd3-587b-41aa-8565-fd3182c8c274.gif)

## ビルド方法
・クローン

```
git clone https://github.com/gadgelogger/github_search_app_study.git
```

 ・fvm読み込み
 
 ```
 fvm use 使うバージョン（x.x.x）
 ```

・依存関係を読み込む（多言語対応も読み込まれます）

```
fvm flutter pub get
```



・ビルドラン

```
fvm flutter run
```

## 技術スタックやら(使用したパッケージ関連)
- アプリの機能
  - GitHub リポジトリの検索と詳細表示
  - 無限スクロール対応
  - いちいち画面転移するのダルいので１画面で完結するイケてるUI（expansion_tile_cardを使用（後述））
- [fast_i18n](https://pub.dev/packages/fast_i18n) を使った多言語対応（日本語/英語）
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) を使ったアプリアイコン
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) を使ったスプラッシュ画面
- [responsive_framework](https://pub.dev/packages/responsive_framework) を使ったレスポンシブ対応
- [GitHub Actions](https://github.co.jp/features/actions) によるCI(自動テストと自動ビルド)
- [expansion_tile_card](https://pub.dev/packages/expansion_tile_card) によるいい感じなUI（画面転移をせずにListをタップするとリポジトリの詳細が閲覧できる）
- [Shimmer](https://pub.dev/packages/shimmer/install)によるイケてるローディングUI（CircularProgressIndicatorは飽きた）
- [url_launcher](https://pub.dev/packages/url_launcher)ブラウザを開く際に使用
- [intl](https://pub.dev/packages/intl)多言語化関連とか日付のフォーマットに使用
- [provider](https://pub.dev/packages/provider)状態管理に使用

- ダークモード対応
- サポートするプラットフォーム
  - iOS / Android 

### 今後対応予定

- 検索結果の並び替えやデータの永続化
- いちいち検索するのダルいので、検索履歴の保存とサジェスト的な機能を作りたい（言い訳：時間が足りなかった）
### 対応しないこと

- Firebase 連携とか

##フォルダ構成
```  
// github_search_app_study/ - プロジェクトのルートディレクトリ
// ├── .fvm/ - FVM関連
// ├── android/ - ネイティブのAndroidコードを格納するためのディレクトリ
// ├── ios/ - ネイティブのiOSコードを格納するためのディレクトリ
// ├── lib/ - Dartのソースコードを格納するためのディレクトリ
// │   ├── main.dart - アプリケーションのエントリーポイント
// │   ├──components/ - コンポーネント化したwidgetを格納するディレクトリ
// │   ├──constants/ - 定数化した値を格納するディレクトリ(colorとか)
// │   ├── screens/ - アプリケーションの各画面を格納するディレクトリ
// │   ├── i18n/ - 多言語化用のファイルを格納するためのディレクトリ
// │   │   ├── search_screen.dart - 検索画面のコードを格納するファイル
// │   ├── providers/ - 状態管理に関するコードを格納するディレクトリ
// │   │   ├── search_provider.dart - 検索機能に関する状態管理のコードを格納するファイル
// │   ├── models/ - データモデルを格納するディレクトリ
// │   │   ├── repository.dart - リポジトリのデータモデルを格納するファイル
// ├── test/ - テストコードを格納するディレクトリ
// │   ├── widget_test.dart - ウィジェットのテストコードを格納するファイル
// ├── pubspec.yaml - アプリケーションの依存関係とメタデータを記述するファイル
// └── README.md - プロジェクトに関する説明とドキュメンテーションを含むファイル
              どの層からもアクセス可能な便利クラス（ロガー、拡張メソッドなど）
```
とりあえず素人ながらわかりやすいようにファイルを分割しています。（API関連はAPI関連/Screen関連はScreenへ）

## CIとか
- [GitHub Actions](https://github.co.jp/features/actions) を利用して CI を構築しています。
  - 設定では `develop` ブランチにプルリクエストが作成や更新された時、 または`push` されたときに CI が作動します。
### ワークフローは以下のようになっており
1.コードのチェックアウト: actions/checkout@v3アクションを使用してリポジトリのコードを取得します。

2.Dartのセットアップ: dart-lang/setup-dartアクションを使用して、実行環境にDartをセットアップします。

3.Flutterのセットアップ: subosito/flutter-action@v2.10.0アクションを使用して、実行環境にFlutterをセットアップします。

4.依存関係のインストール: flutter pub getコマンドを実行して、プロジェクトの依存関係をインストールします。

5.静的コード解析: flutter analyzeコマンドを実行して、プロジェクトのソースコードを静的に解析します。これにより、可能なバグやコードの品質問題を検出できます。

また現在テストの実行はワークフローからコメントアウトしていますが、UnitテストとWidgetテストが実装出来次第、'flutter test'コマンドを使用してフルテストスイートを実行することを計画しています。


## テストとか
- よくわからないのでググってたらなんか色々できるっぽい。。。🤔🤔🤔🤔🤔
  - とりあえず、検索フィールドが存在するかを確認→フィールドにFlutterと入力→エンターを押して問題がなければテストにパスするようにしてみました。

## 雑記
* issueドリブンで開発をしました。
* プルリクエストベースで開発をして、安全に運用しました
* いろんな大きさの画面でも崩れないUIを意識しました。
* GitHub上で見れるようにUrl_launtcherを使いリポジトリを開くボタンを設けました
* 可読性を意識して、widgetの切り分けをしました(componentsに格納して分けた)
* シンプルで使いやすい、スタイリッシュなデザインを意識しました
* 画面転移をしまくると個人的にめんどくさいので、expansion_tile_cardというパッケージを使い、タップしたらカードが開いていい感じに表示されるようにしました
* ユーザーが次のアクションがわかりやすいよう、ロードをshimmerにしました（スタイリッシュでもある）
* 多言語対応は他のアプリに倣ってアプリ内では操作できないようにした


## 感想
* 自分が如何にソフトウェア工学面的に劣っているかがよくわかった
* Githubの基本的な使い方はマスターすることができたのでいい勉強になった(まだコンフリクトとかyamlを書けないけれど)
* アーキテクチャ部分の理解や１行１行のコードが「なぜ動くのか？この仕組みはどうなのか？」がノリと雰囲気で理解できていないのでまだまだ勉強が必要だと感じた
* コードのコンポーネント化やコンスタンス化などを知ることができ、自分が如何に保守性・視認性の悪いコードを書いていたかが痛感した。
* テストコード(Widgetテスト・Unitテスト・Integrationテスト)などについて知ることができた。（widgetしか知らなかった）
* テストコードを今回初めて書いたので拙い部分が多いのでもっと改良していきたい。 

