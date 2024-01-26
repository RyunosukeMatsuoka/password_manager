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
			echo -e "入力されたパスフレーズが異なっています。\n"
		else
			echo "$passphrase" > passphrase.txt
			chmod go-rwx passphrase.txt
			echo -e "GnuPGのパスフレーズを登録しました。\n"
			break
		fi
	done
}

# Add Password が入力された場合の処理
function addPassword (){
	while true
	do
		read -p "サービス名を入力してください:" serviceName
		## 複合化
        	decrypt
		## サービス名を変数に格納
        	S_exists=`grep -x サービス名:$serviceName .store.txt 2> /dev/null`
		
		if [ -z "$serviceName" ]; then
			echo -e "サービス名が未入力です。\n"
		## 既に入力されたサービス名が存在していた場合
		elif [ $S_exists ]; then
			echo -e "そのサービスは既に登録されています。\n"
		else
			echo
			## 暗号化
			encrypt
			break
		fi
		## 暗号化
		encrypt
	done
	
	while true
	do
		read -p "ユーザー名を入力してください:" userName
		if [ -z "$userName" ]; then
                        echo -e "ユーザー名が未入力です。\n"
                else
                        echo
			break
                fi
	done
        
	while true
	do
		read -s -p "パスワードを入力してください:" password
		if [ -z "$password" ]; then
                        echo
			echo -e "パスワードが未入力です。\n"
                else
			echo
                        break
                fi
	done

        info=サービス名:$serviceName$'\n'ユーザー名:$userName$'\n'パスワード:$password$'\n'
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
	while true
        do
                read -p "サービス名を入力してください:" serviceName
                if [ -z "$serviceName" ]; then
                        echo -e "サービス名が未入力です。\n"
                else
			echo
                        break
                fi
        done
        ## 複合化
        decrypt

        ## サービス名が保存されていた場合
	grep -A 3 -x サービス名:$serviceName .store.txt 2> /dev/null

	##サービス名が保存されていなかった場合
	if [ $? = 1 ]; then
		echo -e "そのサービスは登録されていません。\n"
	fi

        ## 暗号化
        encrypt
}

#メイン処理
echo -e "パスワードマネージャーへようこそ！\n"

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
