require 'spec_helper'

describe PagesController do
  describe "GET /pages/feed.xml" do
    before do
      @page = mock_model(Page, :to_param => "1")
      stub(Page).find { @page }
      get "feed", :type => 'xml'
    end

    it { response.should render_template("feed") }
  end
end
