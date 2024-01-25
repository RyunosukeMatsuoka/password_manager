#!/bin/bash

# 暗号化処理
function encrypt (){
        ## .store.txtファイルを暗号化し、.store.txtファイルを削除
        cat passphrase.txt | gpg --batch --passphrase-fd 0 --yes --symmetric .store.txt
        shred -u .store.txt
}

# 複合化処理
function decrypt (){
        ## .store.txt.gpgファイルを複合化し、.store.txtファイルに出力
        cat passphrase.txt | gpg --batch --passphrase-fd 0 --quiet --output .store.txt --decrypt .store.txt.gpg
}

# 初めての使用で、暗号化ファイルが存在しない場合の処理
function addEncfile (){
	Encfile=.store.txt.gpg
	
	if [ ! -e $Encfile ]; then
		touch .store.txt
		encrypt
	fi
}

# パスフレーズの登録処理
function addPassphrase (){
	while true
	do
		read -s -p "GnuPGのパスフレーズを入力してください:" passphrase
		echo
		read -s -p "確認のためにもう一度GnuPGのパスフレーズを入力してください:" checkPassphrase
		echo

		if [ "$passphrase" != "$checkPassphrase" ]; then
			echo "入力されたパスフレーズが異なっています。"
		else
			echo "GnuPGのパスフレーズを登録しました。"
			echo "$passphrase" > passphrase.txt
			chmod go-rwx passphrase.txt
			break
		fi
	done
}

# Add Password が入力された場合の処理
function addPassword (){
	read -p "サービス名を入力してください:" serviceName
        read -p "ユーザー名を入力してください:" userName
        read -p "パスワードを入力してください:" password

        info=サービス名:$serviceName$'\n'ユーザー名:$userName$'\n'パスワード:$password
	## 複合化
        decrypt

        ##ファイルに出力
        echo "$info" >> .store.txt

        ## 暗号化
        encrypt

        echo "パスワードの追加に成功しました。"
}

# Get Password が入力された場合の処理
function getPassword (){
	read -p "サービス名を入力してください：" serviceName
        ## 複合化
        decrypt

        ## サービス名が保存されていた場合
	grep -A 2 -x サービス名:$serviceName .store.txt 2> /dev/null

	##サービス名が保存されていなかった場合
	if [ $? = 1 ]; then
		echo -e "そのサービスは登録されていません。\n"
	fi

        ## 暗号化
        encrypt
}

#メイン処理
echo "パスワードマネージャーへようこそ！"

## パスフレーズの登録
addPassphrase

## 暗号化ファイルが存在するか確認
addEncfile

while true
do	
	read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" selected

	case $selected in
		## Add Password が入力された場合
		"Add Password")
			addPassword
			;;
		## Get Password が入力された場合
		"Get Password")
			getPassword
			;;
		## Exit が入力された場合
		"Exit")
			echo "Thank you!"
			## 登録したパスフレーズを削除
			shred -u passphrase.txt
			## プログラムが終了
			break
			;;
		## Add Password/Get Password/Exit 以外が入力された場合
	        *)
			echo -e "入力が間違えています。Add Password/Get Password/Exit から入力してください。\n";;
	esac
done
