# language: ja

機能: 設定

  シナリオ: ログイン要求

    もし "/settings/profile" を表示する
    ならば URL "/users/sign_in" が表示されている
    かつ "ログインしてください" と表示されている

  シナリオ: プロフィール設定

    前提 "user1" でログインする

    もし "/settings/profile" を表示する
    ならば "h1" に "プロフィール設定" と表示されている

    もし "ニックネーム" に "◯◯◯" と入力する
    かつ "保存" をクリックする
    ならば "変更しました" と表示されている
    かつ "◯◯◯" と表示されている
