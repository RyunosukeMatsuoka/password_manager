# パスワードマネージャー  

各サービスごとに、IDとパスワードを安全に管理するためのツールです。  

## 機能

-   サービス名、ユーザー名、パスワードをGnuPGを利用することで、比較的安全に保存できる。  
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
4. GnuPGに未登録の場合は下記の手順で登録した上で、パスフレーズを準備してください。  
下記のコマンドで鍵を生成してください。  
  ```
  gpg --gen-key
  ```  
  1. 鍵のタイプを設定する。デフォルトのRSAでOK。  
  2. 鍵長を設定する。デフォルトの2048でOK。  
  3. 鍵の有効期限を設定する。デフォルトの0(無期限)でOK。  
  4. 個人情報を設定する。名前、電子メール、メモ(未記入でもOK)を入力。  
  5. パスフレーズを設定する。メモをするなどして、忘れないようにしてください。  
   
   上記の手順でGnuPGに登録できない場合は、下記の公式ドキュメントを参照してください。  
        https://gnupg.org/index.html
## 使用方法

1. 下記のファイルを実行する。
  ```
  ./password_manager.sh
  ```
2. 画面遷移
  ```
  パスワードマネージャーへようこそ！
  # GnuPGのパスフレーズを登録
  GnuPGのパスフレーズを入力してください:
  確認のためにもう一度GnuPGのパスフレーズを入力してください:
  
  ## 入力内容が異なっていた場合
  入力されたパスフレーズが異なっています。

  ## 入力内容が正しかった場合
  GnuPGのパスフレーズを登録しました。

  次の選択肢から入力してください（Add Password/Get Password/Exit）:

  # Add Passwordを選択した場合
  サービス名を入力してください:
  ユーザー名を入力してください:
  パスワードを入力してください:

  パスワードの追加に成功しました。
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

-   同じサービス名を登録できないようにする。

-   ログイン時の処理を一つの処理としてまとめる。

-   パスフレーズが間違っていた場合の処理を追加する。
