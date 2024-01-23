#!/bin/bash

# Add Password が入力された場合の処理
addPassword (){
	read -p "サービス名を入力してください:" service
        read -p "ユーザー名を入力してください:" user
        read -p "パスワードを入力してください:" password

        info=サービス名:$service$'\n'ユーザー名:$user$'\n'パスワード:$password
        ##ファイルに出力
        echo "$info" >> store.txt

        echo "パスワードの追加は成功しました。"
}

# Get Password が入力された場合の処理
getPassword (){
	read -p "サービス名を入力してください：" service

        ## サービス名が保存されていた場合
	grep -A 2 -x サービス名:$service store.txt 2> /dev/null

	##サービス名が保存されていなかった場合
	if [ $? = 1 ]; then
		echo -e "そのサービスは登録されていません。\n"
	fi
}

#メイン処理
echo "パスワードマネージャーへようこそ！"

while true
do
	read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" selected

	case $selected in
		# Add Password が入力された場合
		"Add Password")
			addPassword
			;;
		# Get Password が入力された場合
		"Get Password")
			getPassword
			;;
		# Exit が入力された場合
		"Exit")
			echo "Thank you!"
			## プログラムが終了
			break
			;;
		# Add Password/Get Password/Exit 以外が入力された場合
	        *)
			echo -e "入力が間違えています。Add Password/Get Password/Exit から入力してください。\n";;
	esac
done
