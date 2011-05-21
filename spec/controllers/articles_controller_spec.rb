require 'spec_helper'

describe ArticlesController do
  describe "handling Atomfeed" do
    before do
      @articles = [mock_model(Article, :to_param => "1")]
      Article.stub(:publishing) { @articles }
      @articles.stub(:newer_first) { @articles }
      get "feed", :type => 'xml'
    end

    it { response.should render_template("feed") }
  end
end
