# coding: utf-8

require 'spec_helper'

describe ArticlesController do
  describe '未公開の記事' do
    let(:article) { Fabricate(:article, publishing: false) }

    context 'ログインしていると' do
      before do
        controller.stub(:current_user) { Fabricate(:user) }

        get :show, id: article.id
      end

      it { response.should be_success }
    end

    context 'ログインしていないと' do
      before do
        get :show, id: article.id
      end

      it { response.should redirect_to(signin_path(origin: article_path(article))) }
    end
  end
end
