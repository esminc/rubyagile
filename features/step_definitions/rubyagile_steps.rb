# coding:utf-8

前提 /^ユーザーがログインしている$/ do
  Fabricate(:authorized_user)
  Given %["ログイン"ページを表示している]
  When  %["twitter"リンクをクリックする]
end
