# coding:utf-8

前提 /^ユーザーがログインしている$/ do
  Fabricate(:authorized_user)
  step %["ログイン"ページを表示している]
  step %["twitter"リンクをクリックする]
end
