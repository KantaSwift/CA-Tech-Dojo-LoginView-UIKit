# CA-Tech-Dojo-LoginView-UIKit

## 概要
CATechDojo~に参加させていただいたときに、制作したアプリのログイン画面だけの切り抜き。

インターンのアウトプットとなっております。

[こちらに](https://qiita.com/kanta_Swift/items/c893cf402dd520a019c5)当時の状況に述べた記事があります。

興味ありましたら一読お願い致します🙏


## 目次

- [スクリーンショット](#スクリーンショット)
- [開発](#構成)
- [主な実装機能](#主な実装機能)

## スクリーンショット
<img src="https://github.com/KantaSwift/CA-Tech-Dojo-LoginView-UIKit/assets/101320551/68783cd6-6bd0-4744-88d7-6acb88141c68" width="200">

## 構成
- UIの実装: UIKit+Combine
- アーキテクチャ: MVVM+Repository

## 主な実装機能
- 本アプリのアカウント名となる名前とTwitter、Githubのアカウント名の入力: UserDefalutsに保存
- バリデーション機能: 空欄とひらがな🙅‍♂️(TwitterとGithubのアカウント名のみ)
- データの永続化: Codableに準拠

## ライブラリ
- SnapKit
- CombineCocoa
