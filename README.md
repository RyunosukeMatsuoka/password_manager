# パスワードマネージャー  

各サービスごとに、IDとパスワードを安全に管理するためのツールです。  

## 機能

-   サービス名、ユーザー名、パスワードを保存できる。  
-   サービス名を入力することで、保存した内容を確認できる。  

## 事前準備
1. このリポジトリをクローンする。
  ```
  git clone https://github.com/ryunosukematsuoka/password_manager.git
  ```
2. パスワードマネージャーのディレクトリに移動する。
  ```
  cd ~/Documents/git1/passmane
  ```
3. パスワードマネージャーを利用する権限を付与する。
  ```
  chmod 500 ./password_manager.sh
  ```

## 使用方法

1. 下記のファイルを実行する。
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

  ## 入力したサービス名が保存されていなかった場合
  そのサービスは登録されていません。

  ## 入力したサービス名が保存されていた場合
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

### ファイルを暗号化する。
-   Add Password が入力された場合、サービス名、ユーザー名、パスワードをファイルに保存した後にファイルを暗号化する。
-   Get Password が入力された場合、暗号化されたファイルを復号化して（元の状態に戻して）サービス名、ユーザー名、パスワードを表示する。なおその際に、ファイルそのものは暗号化された状態を維持する（Get Password後にファイルを開いてもファイルは暗号化されている）。

### バリデーション処理
-   Add Password が入力された場合、サービス名、ユーザー名、パスワードのそれぞれで入力されていないとエラーを表示する。
