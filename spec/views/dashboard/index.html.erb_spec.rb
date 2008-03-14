require File.dirname(__FILE__) + '/../../spec_helper'

describe "/dashboard/index" do
  before(:each) do
    login_as(:alice)

    @article = mock_model(Article, :title => 'a_title', :published? => true)
    @articles = assigns[:articles] = [@article]
    render 'dashboard/index'
    template.stub!(:render_status_for).with(:anything).and_return("公開")
  end

  it { response.should have_tag('div.articles') }
end
