# 10BOOKS

## アプリケーションの概要
[10BOOKS](https://ten-books.herokuapp.com/)は、自分の人生に強い影響を与えた10冊の本をピックアップして登録・公開することのできるアプリケーションです。様々な人の人生を変えた書籍を閲覧し学ぶことができます。

## 機能一覧と使用した技術
* データベース(mysql)
* CSSフレームワーク(materialize)
* デプロイ(heroku)
* テスト(Rspec,minitest)
* ユーザー有効化とパスワードリセット(ActionMailer)
* ページネーション(kaminari)
* ユーザー登録機能
* 認証機能
* SNSによるログイン機能(omniauth-facebook)
* 書籍検索機能(google books api)
* 書籍登録機能
* 書籍にコメントをつける機能
* ユーザープロフィール画像変更機能(CarrierWave, AWS s3)
* 本棚をお気に入りに登録する機能(Ajax)
* 本棚にコメントをつける機能
* 登録されている書籍のランキング機能
* 本棚のいいね数によるランキング機能
* ユーザー検索機能(Searchcop)
* API

## データベース構造
### Usersテーブル
| column | type | option |
|:-----------|------------:|:------------:|
| id | integer | null: false |
| name | string | |
| email | string | *add_index |
| created_at | datetime | null: false |
| updated_at | datetime  | null: false |
| password_digest | string ||
| remember_digest | string ||
| admin | boolean | default: false |
| activation_digest | string ||
| activated | boolean | default: false |
| activated_at | datetime  ||
| reset_digest | string ||
| reset_sent_at | datetime  ||
| comments | text ||
| picture | string ||
| job | string ||

##### association
*  has_many :books
*  has_many :book_comments
*  has_many :active_relationships
*  has_many :passive_relationships
*  has_many :authorizations

### Booksテーブル
| column | type | option |
|:-----------|------------:|:------------:|
| id | integer | null: false |
| title | string | *add_index |
| authors | string ||
| published_date | string | null: false |
| image_link | string  | null: false |
| user_id| bigint | *add_index |
| created_at | datetime | *add_index |
| updated_at | datetime  | null: false |
| isbn | bigint | *add_index |
| info_link | string ||

##### association
*  belongs_to :user
*  has_many :book_comments

### Likesテーブル
| column | type | option |
|:-----------|------------:|:------------:|
| id | integer | null: false |
| user_id | integer | *add_index |
| liked_id | integer | *add_index |
| created_at | datetime | null: false |
| updated_at | datetime  | null: false |

##### association
*  belongs_to :user, class_name: "User"
*  belongs_to :liked, class_name: "User"

### BookCommentsテーブル
| column | type | option |
|:-----------|------------:|:------------:|
| id | integer | null: false |
| content | text | |
| user_id | bigint | *add_index |
| book_id | bigint | *add_index |
| created_at | datetime | null: false |
| updated_at | datetime  | null: false |


##### association
*  belongs_to :user
*  belongs_to :book

### Authorizationテーブル
| column | type | option |
|:-----------|------------:|:------------:|
| id | integer | null: false |
| provider | string | |
| uid | string | |
| user_id | bigint | |
| created_at | datetime | null: false |
| updated_at | datetime  | null: false |


##### association
*  belongs_to :user
