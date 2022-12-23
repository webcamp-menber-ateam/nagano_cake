## ながのCAKE

<p align="center"><img src="https://github.com/webcamp-menber-ateam/nagano_cake/blob/develop/app/assets/images/logo_image.png" alt="nagano_cake" title="nagano_cake_log" width="130" height="130" /></p>

## 案件概要

長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト開発。

## 実装機能

- 会員側

  - 顧客は新規会員登録、ログイン・ログアウト、退会することができる

  - ログイン後はログイン時のみ利用できる機能が利用できる

  - 商品を一覧で表示し、商品一覧の「商品画像」を押下すると商品詳細に遷移することができる

  - カートに商品を追加、カートの中身の個数の編集、削除（1個、またはカート内全て削除）をすることができる

  - 注文時、支払方法と発送先を設定することができる

  - 会員情報編集から登録している情報の編集、退会手続きをすることができる

  - 配送先の新規登録、登録している配送先を一覧での表示、配送先の修正・削除をすることができる

  - 注文経歴から過去の注文履歴を一覧で確認することができる

　- 注文履歴一覧から注文詳細を確認することができる

  - 会員はトップ画面からジャンル検索を行うことができる

- 管理者側

  - メールアドレス、パスワードでログインすることができ、ログイン時のみ利用できる機能が利用できるようになる

  - 管理者トップページで過去の注文履歴を一覧で確認することができる

  - 過去の注文履歴の「購入日時」を押下すると詳細を確認することができ、注文ステータス、製作ステータスを変更することができる

  - 過去の注文履歴一覧の「購入者」またはヘッダーの「会員一覧」→「氏名」を押下すると顧客情報を一覧で表示することができる

  - 顧客情報の検索結果を表示する場合は、検索条件に当てはまる顧客のみ一覧表示することができる

  - 顧客の詳細情報、顧客のステータス（有効/退会）を切り替えることができる

  - 登録商品を一覧で確認することができ、「商品名」を押下すると商品の詳細情報を確認することができる

  - 商品の新規登録をすることができ、登録されている商品の情報と販売ステータスを変更することができる

  - ジャンルの追加・変更を行うことができる

#### 顧客側・管理者側共通してヘッダーから商品を検索することができる

## 設計書

- [ER図](https://drive.google.com/file/d/1jgz4aO2qnzrF1evnixtuYmVADjVLljv2/view)

- [テーブル定義書](https://drive.google.com/file/d/1IK7nYIFtvjW8_SWjJNalePKWTGFlo_Zr/view)

- [アプリケーション詳細設計書](https://drive.google.com/file/d/1aQcHwLI7RavTQZEQc651dnfjxXth3GVb/view)

## 環境構築に必要な手順

kaminariのページネーション設定

    $ rails g kaminari:config

    $ rails g kaminari:views default

 RailsにBootstrapを導入する

    $ yarn install

    $ yarn add jquery bootstrap@4.5 popper.js

 FontAwesomeの導入

    $ yarn add @fortawesome/fontawesome-free@5.15.4

    $ bundle install

 ActiveStorageをインストールする

    $ rails active_storage:install

 migrateする

    $ rails db:migrate

## 開発環境

- Ruby 3.1.2

- Rails 6.1.7

## Gem

- devise

- enum_help

- bootstrap

- kaminari 1.2.1'

- pry-byebug

- pry-rails

- better_errors

- image_processing 1.2

- FontAwesome（yarn)

- devise-i18n

- devise-i18n-views

## 作成者

**チーム「アジのひらき」**

  - あつし

  - ゆーさん

  - ゆーきゃん

  - やっさん
