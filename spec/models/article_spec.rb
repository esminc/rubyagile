require File.dirname(__FILE__) + '/../spec_helper'

describe Article do
  fixtures :users

  describe "必要な項目が揃っている場合" do
    before(:each) do
      @article = Article.new(:user => users(:valid), :title => 't', :body => 'b')
    end

    it { @article.should be_valid }
  end
end
