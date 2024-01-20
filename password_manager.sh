#!/bin/bash

echo "パスワードマネージャーへようこそ！"

#パスワードの保存処理
read -p "サービス名を入力してください:" service
read -p "ユーザー名を入力してください:" user	
read -p "パスワードを入力してください:" password

info=$service:$user:$password
#ファイルに出力
echo "$info" >> store.txt

echo "Thank you!"
