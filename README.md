# パスワードマネージャー  

各サービスごとに、IDとパスワードを安全に管理するためのツールです。  

## 機能

-   サービス名、ユーザー名、パスワードを保存できる。  
-   サービス名を入力することで、保存した内容を確認できる。  

##事前準備
1. リポジトリをクローンする。
  ```
  git clone https://github.com/ryunosukematsuoka/password_manager.git
  ```
2. ディレクトリを移動
  ```
  cd ~/Documents/git1/passmane
  ```
3. 権限を付与
  ```
  chmod 500 ./password_manager.sh
  ```

##使用方法

1. 下記のファイルを実行
  ```
  ./password_manager.sh
  ```
2. 画面遷移
  ```
  パスワードマネージャーへようこそ！
  次の選択肢から入力してください（Add Password/Get Password/Exit）:

  # Add Passwordを選択した場合
  サービス名を入力してください:
  ユーザー名を入力してください:
  パスワードを入力してください:

  パスワードの追加は成功しました。
  次の選択肢から入力してください（Add Password/Get Password/Exit）:

  # Get Passwordを選択した場合
  サービス名を入力してください:

  ## サービス名が保存されていなかった場合
  そのサービスは登録されていません。

  ## サービス名が保存されていた場合
  サービス名:dai
  ユーザー名:chu
  パスワード:shou

  次の選択肢から入力してください（Add Password/Get Password/Exit）:

  # Exitを選択した場合
  Thank you!
  ##プログラムが終了

  # Add Password/Get Password/Exit 以外が入力された場合
  入力が間違えています。Add Password/Get Password/Exit から入力してください。

  次の選択肢から入力してください（Add Password/Get Password/Exit）:
  ```
## 展望

//パスワードマネージャーの作成後に追記

