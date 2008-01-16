require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/edit.html.erb" do
  include ArticlesHelper
  
  before do
    @article = mock_model(Article)
    assigns[:article] = @article
  end

  it "should render edit form" do
    render "/articles/edit.html.erb"
    
    response.should have_tag("form[action=#{article_path(@article)}][method=post]") do
    end
  end
end


