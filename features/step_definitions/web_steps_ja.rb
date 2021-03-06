# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

前提 /^"([^"]*)"ページを表示している$/ do |page_name|
  step %{I am on #{page_name}}
end

もし /^"([^"]*)"ページを表示する$/ do |page_name|
  step %{I go to #{page_name}}
end

もし /^"([^"]*)"ボタンをクリックする$/ do |button|
  step %{I press "#{button}"}
end

もし /^"([^"]*)"(リンク|ボタン)をクリックしてポップアップを無視する$/ do |label, ctrl|
  page.evaluate_script("window.alert = function(msg) { return true; }")
  page.evaluate_script("window.confirm = function(msg) { return true; }")
  step %{"#{label}"#{ctrl}をクリックする}
end

もし /^"([^"]*)"リンクをクリックする$/ do |link|
  step %{I follow "#{link}"}
end

もし /^"([^"]*)"の"([^"]*)"リンクをクリックする$/ do |parent, link|
  step %{I follow "#{link}" within "#{parent}"}
end

もし /^"([^"]*)"に"([^"]*)"と入力する$/ do |field, value|
  step %{I fill in "#{field}" with "#{value}"}
end

# less difference to %{I fill in "#{value}" for "#{field}"} with above in Japanese.

もし /^以下の項目を入力する:$/ do |fields|
  step %{I fill in the following:}, fields
end

もし /^"([^"]*)"から"([^"]*)"を選択する$/ do |field, value|
  step %{I select "#{value}" from "#{field}"}
end

もし /^日時として"([^"]*)"を選択する$/ do |time|
  step %{I select "#{time}" as the date and time}
end

もし /^"([^"]*)"の日時として"([^"]*)"を選択する$/ do |datetime_label, datetime|
  step %{I select "#{datetime}" as the "#{datetime_label}" date and time}
end

もし /^時間として"([^"]*)"を選択する$/ do |time|
  step %{I select "#{time}" as the time}
end

もし /^"([^"]*)"の時間として"([^"]*)"を選択する$/ do |time_label, time|
  step %{I select "#{time}" as the "#{time_label}" time}
end

もし /^日付として"([^"]*)"を選択する$/ do |date|
  step %{I select "#{date}" as the date}
end

もし /^"([^"]*)"の日付として"([^"]*)"を選択する$/ do |date_label, date|
  step %{I select "#{date}" as the "#{date_label}" date}
end

もし /^"([^"]*)"をチェックする$/ do |field|
  step %{I check "#{field}"}
end

もし /^"([^"]*)"のチェックを外す$/ do |field|
  step %{I uncheck "#{field}"}
end

もし /^"([^"]*)"を選択する$/ do |field|
  step %{I choose "#{field}"}
end

もし /^"([^"]*)"としてファイル"([^"]*)"を選択する$/ do |field, path|
  step %{I attach the file "#{path}" to "#{field}"}
end

ならば /^"([^"]*)"と表示されていること$/ do |text|
  step %{I should see "#{text}"}
end

ならば /^"([^"]*)"に"([^"]*)"と表示されていること$/ do |selector, text|
  step %{I should see "#{text}" within "#{selector}"}
end

ならば /^\/([^\/]*)\/と表示されていること$/ do |regexp|
  step %{I should see /#{regexp}/}
end

ならば /^"([^"]*)"に\/([^\/]*)\/と表示されていること$/ do |selector, regexp|
  step %{I should see \/#{regexp}\/ within "#{selector}"}
end

ならば /^"([^"]*)"と表示されていないこと$/ do |text|
  step %{I should not see "#{text}"}
end

ならば /^"([^"]*)"に"([^"]*)"と表示されていないこと$/ do |selector, text|
  step %{I should not see "#{text}" within "#{selector}"}
end

ならば /^\/([^\/]*)\/と表示されていないこと$/ do |regexp|
  step %{I should not see /#{regexp}/}
end

ならば /^"([^"]*)"に\/([^\/]*)\/と表示されていないこと$/ do |selector, regexp|
  step %{I should not see \/#{regexp}\/ within "#{selector}"}
end

ならば /^入力項目"([^"]*)"に"([^"]*)"と表示されていること$/ do |field, value|
  step %{the "#{field}" field should contain "#{value}"}
end

ならば /^入力項目"([^"]*)"に"([^"]*)"と表示されていないこと$/ do |field, value|
  step %{the "#{field}" field should not contain "#{value}"}
end

ならば /^"([^"]*)"がチェックされていること$/ do |label|
  step %{the "#{label}" checkbox should be checked}
end

ならば /^"([^"]*)"がチェックされていないこと$/ do |label|
  step %{the "#{label}" checkbox should not be checked}
end

ならば /^"([^"]*)"ページを表示していること$/ do |page_name|
  step %{I should be on #{page_name}}
end

show_me_the_page = lambda { step %{show me the page} }

ならば /^ページを表示する$/, &show_me_the_page
ならば /^画面を目視$/, &show_me_the_page

# backword-compat for old japanese translation.
ならば /^デバッグ(?:のため)?$/, &show_me_the_page
